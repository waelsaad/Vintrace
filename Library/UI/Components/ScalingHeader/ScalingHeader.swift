//
//  ScalingHeader.swift
//  Library
//
//  Created by Wael Saad on 10/8/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI
import SwiftUIIntrospect

// swiftlint:disable type_body_length

struct ScalingHeader<Header: View, FixedView: View, Content: View>: View {

	/// Content on the top, which will be collapsed
	var header: Header

	/// fixed content on the bottom of header
	var fixedView: FixedView

	/// Content
	var content: Content

	/// Should the progress view be showing or not, when "pull to refresh" action
	@State private var pullToRefreshInProgress = false

	/// Should show the progress view during "pull to load more" action
	@State private var pullToLoadMoreInProgress = false

	/// UIKit's UIScrollView
	@State private var uiScrollView: UIScrollView?

	/// Sets the opacity value for pull-to-load-more progress view
	@State private var pullToLoadOpacity: CGFloat = 1.0

	/// Sets the opacity value for pull-to-refresh progress view
	@State private var pullToRefreshOpacity: CGFloat = 1.0

	/// Scroll view acceleration value. It's set in the scroll mode, when user about to end dragging
	@State private var acceleration: Double = 0

	/// UIScrollView delegate, needed for calling didPullToRefresh or didEndDragging
	@StateObject private var scrollViewDelegate = ScalingHeaderDelegate()

	/// ScrollView's content frame, needed for calculation of frame changing
	@StateObject private var contentFrame = ViewFrame()

	/// Interpolation from 0 to 1 of current collapse progress
	@Binding private var progress: CGFloat

	/// Current scroll offset Y value
	@Binding private var scrollOffset: CGFloat

	/// Automatically sets to true, if pull to refresh is triggered. Manually set to false to hide loading indicator.
	@Binding private var isLoading: Bool

	/// Set to true to immediately scroll to top
	@Binding private var scrollToTop: Bool

	/// Use this variable to programmatically change header's visibility state
	@Binding private var shouldSnapTo: SnapHeaderState?

	/// Called once pull to refresh is triggered
	private var didPullToRefresh: (() -> Void)?

	/// Called once pull to load more is triggered
	private var didPullToLoadMore: (() -> Void)?

	/// Height for uncollapsed state
	private var maxHeight: CGFloat = 350.0

	/// Height for collapsed state
	private var minHeight: CGFloat = 150.0

	/// Allow collapsing while scrolling up
	private var allowsHeaderCollapseFlag = false

	/// Animation, when header size will be changed
	private var headerAnimation: Animation?

	/// Allow enlarging while pulling down
	private var allowsHeaderGrowthFlag = false

	/// Use this variable to set the padding value of the content from the edge when pull-to-load is active
	private var pullToLoadMoreContentOffset: CGFloat = 0.0

	/// Shows or hides the indicator for the scrollView
	private var showsIndicators = true

	/// Allow force snap to closest position after lifting the finger, i.e. forbid to be left in unfinished state
	/// Specify any amount of values in 0...1 to set snapping points, 0 - fully collapsed header, 1 - fully expanded
	private var headerSnappingPositions: [CGFloat] = []

	/// Flag whether the snapping should wait until scrolling has finished accelerating
	private var headerSnappingShouldWaitFinishAccelerating = false

	/// Use this to set initial scroll position to anything other than fully expanded
	/// Set a value in 0...1, 0 - fully collapsed header, 1 - fully expanded
	private var initialSnapPosition: CGFloat?

	/// Alignment for header content
	private var headerAlignment: Alignment = .center

	/// Clipped or not header
	private var headerIsClipped = true

	/// Private computed properties
	private var hasPullToRefresh: Bool {
		didPullToRefresh != nil
	}

	private var hasPullToLoadMore: Bool {
		didPullToLoadMore != nil
	}

	private var contentOffset: CGFloat {
		isLoading && pullToRefreshInProgress ? maxHeight + 32 : pullToLoadMoreContentOffsetValue
	}

	private var pullToLoadMoreContentOffsetValue: CGFloat {
		isLoading && pullToLoadMoreInProgress ? maxHeight - pullToLoadMoreContentOffset : maxHeight
	}

	private var progressViewOffset: CGFloat {
		isLoading ? maxHeight + 24.0 : maxHeight
	}

	/// height for header: reduced if reducing is allowed, or fixed if not
	private var headerHeight: CGFloat {
		allowsHeaderCollapseFlag ? getHeightForHeaderView() : maxHeight
	}

	/// Scaling for header: to enlarge while pulling down
	private var headerScaleOnPullDown: CGFloat {
		!hasPullToRefresh && allowsHeaderGrowthFlag ? fmax(1.0, getHeightForHeaderView() / maxHeight * 0.9) : 1.0
	}

	private var showPullToRefreshProgress: Bool {
		hasPullToRefresh && (isLoading && pullToRefreshInProgress)
	}

	private var showPullToLoadMoreProgress: Bool {
		hasPullToLoadMore && (isLoading && pullToLoadMoreInProgress)
	}

	// MARK: - Init

	init(@ViewBuilder header: @escaping () -> Header, @ViewBuilder fixedView: @escaping () -> FixedView, @ViewBuilder content: @escaping () -> Content) {
		self.header = header()
		self.fixedView = fixedView()
		self.content = content()
		_progress = .constant(0)
		_scrollOffset = .constant(0)
		_isLoading = .constant(false)
		_scrollToTop = .constant(false)
		_shouldSnapTo = .constant(nil)
	}

	// MARK: - Body builder

	var body: some View {
		GeometryReader { globalGeometry in
			ScrollView(showsIndicators: showsIndicators) {
				content
					.offset(y: contentOffset)
					.frameGetter($contentFrame.frame)
					.onChange(of: contentFrame.frame) { frame in
						pullToRefreshInProgress = frame.minY - globalGeometry.frame(in: .global).minY > 20.0
					}
					.onChange(of: scrollToTop) { value in
						if value {
							scrollToTop = false
							setScrollPositionTo(.expanded)
						}
					}
					.onChange(of: shouldSnapTo) { value in
						if let value = value {
							shouldSnapTo = nil
							setScrollPositionTo(value)
						}
					}
				GeometryReader { scrollGeometry in
					ZStack(alignment: .topLeading) {
						if showPullToRefreshProgress {
							progressView
								.opacity(pullToRefreshOpacity)
								.offset(y: getOffsetForHeader() + progressViewOffset)
						}
						header
							.frame(height: headerHeight, alignment: headerAlignment)
							.clipped(isClipped: headerIsClipped)
							.offset(y: getOffsetForHeader())
							.allowsHitTesting(true)
							.scaleEffect(headerScaleOnPullDown)

						fixedView
							.frame(height: fixedViewHeight)
							.padding(.top, 15)
							.offset(y: getOffsetForHeader() + (headerHeight - fixedViewHeight))
					}
					.offset(y: getGeometryReaderVsScrollView(scrollGeometry: scrollGeometry, globalGeometry: globalGeometry))
				}
				.background(Color.clear)
				.frame(height: maxHeight)
				.offset(y: -(contentFrame.startingRect?.maxY ?? UIScreen.main.bounds.height))
			}
			.animation(headerAnimation, value: shouldSnapTo)
			.introspect(.scrollView, on: .iOS(.v15, .v16, .v17)) { scrollView in
				configure(scrollView: scrollView)
			}
			.onAppear {
				snapInitialScrollPosition()
			}
			if showPullToLoadMoreProgress {
				progressView
					.opacity(pullToLoadOpacity)
					.offset(y: globalGeometry.size.height - 60)
			}
		}
	}

	private var fixedViewHeight: CGFloat {
		allowsHeaderCollapseFlag ? getHeightForHeaderView() : 0
	}

	// MARK: - Private Views

	private var progressView: some View {
		ProgressView()
			.progressViewStyle(CircularProgressViewStyle())
			.frame(width: UIScreen.main.bounds.width, height: getHeightForLoadingView())
			.scaleEffect(1.25)
	}

	// MARK: - Private configure

	private func configure(scrollView: UIScrollView) {
		scrollView.delegate = scrollViewDelegate
		if let didPullToRefresh = didPullToRefresh {
			scrollViewDelegate.didPullToRefresh = {
				pullToLoadMoreInProgress = false
				pullToRefreshInProgress = true
				withAnimation { isLoading = true }
				didPullToRefresh()
			}
		}
		if let didPullToLoadMore = didPullToLoadMore {
			scrollViewDelegate.didPullToLoadMore = {
				pullToLoadMoreInProgress = true
				pullToRefreshInProgress = false
				withAnimation { isLoading = true }
				didPullToLoadMore()
			}
		}
		scrollViewDelegate.didScroll = {
			DispatchQueue.main.async {
				self.progress = getCollapseProgress()
				self.scrollOffset = -getScrollOffset()
				withAnimation {
					pullToRefreshOpacity = -getScrollOffset() > 32.0 ? 0 : 1
					pullToLoadOpacity = -getScrollOffset() < getMaxYOffset() ? 0 : 1
				}
			}
		}
		scrollViewDelegate.didEndDragging = {
			guard !headerSnappingPositions.isEmpty else { return }

			// if waiting for acceleration to complete is disabled or if acceleration is very slow
			if !headerSnappingShouldWaitFinishAccelerating || fabs(acceleration) < 0.2 {
				snapScrollPosition()
			}
		}

		scrollViewDelegate.willEndDragging = { acceleration in
			if headerSnappingShouldWaitFinishAccelerating {
				self.acceleration = acceleration
			}
		}

		scrollViewDelegate.didEndDecelerating = {
			if headerSnappingShouldWaitFinishAccelerating && !headerSnappingPositions.isEmpty {
				snapScrollPosition()
			}
		}

		DispatchQueue.main.async {
			if uiScrollView != scrollView {
				uiScrollView = scrollView
				snapInitialScrollPosition()
			}
		}
	}

	// MARK: - Private actions

	private func setScrollPositionTo(_ state: SnapHeaderState) {
		guard var contentOffset = uiScrollView?.contentOffset else { return }
		switch state {
		case .expanded:
			contentOffset.y = 0
		case .collapsed:
			contentOffset.y = maxHeight - minHeight
		case .custom(let value):
			contentOffset.y = maxHeight - minHeight + value
		}
		uiScrollView?.setContentOffset(contentOffset, animated: true)
	}

	private func snapScrollPosition() {
		guard var contentOffset = uiScrollView?.contentOffset else { return }

		let extraSpace: CGFloat = maxHeight - minHeight
		let offset = contentOffset.y
		for i in 0..<headerSnappingPositions.count - 1 {
			let first = headerSnappingPositions[i] * extraSpace
			let second = headerSnappingPositions[i + 1] * extraSpace
			if offset > first, offset < second {
				let result: CGFloat
				if (offset - first) < (second - offset) { // closer to first point
					result = first
				} else {
					result = second
				}
				contentOffset.y = result
				uiScrollView?.setContentOffset(contentOffset, animated: true)
				return
			}
		}
	}

	private func snapInitialScrollPosition() {
		if let initialSnapPosition = initialSnapPosition {
			guard var contentOffset = uiScrollView?.contentOffset else { return }
			let extraSpace: CGFloat = maxHeight - minHeight
			contentOffset.y = initialSnapPosition * extraSpace
			uiScrollView?.setContentOffset(contentOffset, animated: true)
		}
	}

	// MARK: - Private getters for heights and offsets

	private func getScrollOffset() -> CGFloat {
		-(uiScrollView?.contentOffset.y ?? 0)
	}

	private func getMaxYOffset() -> CGFloat {
		(uiScrollView?.contentSize.height ?? 0.0) - (uiScrollView?.bounds.height ?? 0.0)
	}

	private func getContentHeight() -> CGFloat {
		uiScrollView?.contentSize.height ?? 0.0
	}

	private func getGeometryReaderVsScrollView(scrollGeometry: GeometryProxy, globalGeometry: GeometryProxy) -> CGFloat {
		getScrollOffset() - scrollGeometry.frame(in: .global).minY + globalGeometry.frame(in: .global).minY
	}

	private func getOffsetForHeader() -> CGFloat {
		let offset = getScrollOffset()
		let extraSpace = maxHeight - minHeight

		if offset < -extraSpace {
			let imageOffset = abs(fmin(-extraSpace, offset))
			return allowsHeaderCollapseFlag ? imageOffset : (minHeight - maxHeight) - offset
		} else if offset > 0 {
			return -offset
		}
		return maxHeight - headerHeight
	}

	private func getHeightForHeaderView() -> CGFloat {
		let offset = getScrollOffset()
		if hasPullToRefresh {
			return fmin(fmax(minHeight, maxHeight + offset), maxHeight)
		} else {
			return fmax(minHeight, maxHeight + offset)
		}
	}

	private func getCollapseProgress() -> CGFloat {
		1 - fmin(fmax((getHeightForHeaderView() - minHeight) / (maxHeight - minHeight), 0), 1)
	}

	private func getHeightForLoadingView() -> CGFloat {
		fmax(0, getScrollOffset())
	}
}

// MARK: - Extension View

extension View {

	@ViewBuilder
	func clipped(isClipped: Bool) -> some View {
		if isClipped {
			self.clipped()
		} else {
			self
		}
	}
}

// MARK: - Modifiers

extension ScalingHeader {

	/// Passes current collapse progress value into progress binding
	func collapseProgress(_ progress: Binding<CGFloat>) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView._progress = progress
		return scalingHeaderScrollView
	}

	/// Passes current scroll offset value into binding
	func scrollOffset(_ scrollOffset: Binding<CGFloat>) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView._scrollOffset = scrollOffset
		return scalingHeaderScrollView
	}

	/// Allows to set up callback and `isLoading` state for pull-to-refresh action
	func pullToRefresh(isLoading: Binding<Bool>, perform: @escaping () -> Void) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView._isLoading = isLoading
		scalingHeaderScrollView.didPullToRefresh = perform
		return scalingHeaderScrollView
	}

	/// Allows to set up callback and `isLoading` state for pull-to-load-more action
	func pullToLoadMore(isLoading: Binding<Bool>, contentOffset: CGFloat, perform: @escaping () -> Void) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView._isLoading = isLoading
		scalingHeaderScrollView.pullToLoadMoreContentOffset = contentOffset
		scalingHeaderScrollView.didPullToLoadMore = perform
		return scalingHeaderScrollView
	}

	/// Allows content scroll reset, need to change Binding to `true`
	func scrollToTop(resetScroll: Binding<Bool>) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView._scrollToTop = resetScroll
		return scalingHeaderScrollView
	}

	/// Changing the size of the header at the moment
	func snapHeaderToState(_ state: Binding<SnapHeaderState?>, animated: Bool = true) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView.headerAnimation = animated ? .default : nil
		scalingHeaderScrollView._shouldSnapTo = state
		return scalingHeaderScrollView
	}

	/// Changes min and max heights of Header
	func height(min: CGFloat = 150.0, max: CGFloat = 350.0) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView.minHeight = min
		scalingHeaderScrollView.maxHeight = max
		return scalingHeaderScrollView
	}

	/// When scrolling up - switch between actual header collapse and simply moving it up
	func allowsHeaderCollapse(_ allows: Bool = true) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView.allowsHeaderCollapseFlag = allows
		return scalingHeaderScrollView
	}

	/// When scrolling down - enable/disable header scale
	func allowsHeaderGrowth(_ allows: Bool = true) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView.allowsHeaderGrowthFlag = allows
		return scalingHeaderScrollView
	}

	/// Enable header snap (once you lift your finger header snaps either to min or max height automatically)
	@available(*, deprecated, message: "Use `setHeaderSnapMode()` instead. Will be removed in future releases.")
	func allowsHeaderSnap() -> ScalingHeader {
		setHeaderSnapMode(.immediately)
	}

	/// Enable/disable header snap with snap mode selection
	/// - Parameter mode: Options for modes. Details see in ``SnapHeaderMode``
	/// - SeeAlso: ``SnapHeaderMode``
	func setHeaderSnapMode(_ mode: SnapHeaderMode) -> ScalingHeader {
		var scalingHeaderScrollView = self
		switch mode {
		case .disabled:
			scalingHeaderScrollView.headerSnappingPositions = []
			scalingHeaderScrollView.headerSnappingShouldWaitFinishAccelerating = false
		case .immediately:
			if scalingHeaderScrollView.headerSnappingPositions.isEmpty {
				scalingHeaderScrollView.headerSnappingPositions = [0, 1]
			}
			scalingHeaderScrollView.headerSnappingShouldWaitFinishAccelerating = false
		case .afterFinishAccelerating:
			if scalingHeaderScrollView.headerSnappingPositions.isEmpty {
				scalingHeaderScrollView.headerSnappingPositions = [0, 1]
			}
			scalingHeaderScrollView.headerSnappingShouldWaitFinishAccelerating = true
		}
		return scalingHeaderScrollView
	}

	/// Set positions for header snap (once you lift your finger header snaps to closest allowed position)
	func headerSnappingPositions(snapPositions: [CGFloat]) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView.headerSnappingPositions = snapPositions
		return scalingHeaderScrollView
	}

	/// Use this to set initial scroll position to anything other than fully expanded
	func initialSnapPosition(initialSnapPosition: CGFloat) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView.initialSnapPosition = initialSnapPosition
		return scalingHeaderScrollView
	}

	/// Hides scroll indicators
	func hideScrollIndicators(_ hide: Bool = false) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView.showsIndicators = hide
		return scalingHeaderScrollView
	}

	/// Header clipped
	func headerIsClipped(_ isClipped: Bool = true) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView.headerIsClipped = isClipped
		return scalingHeaderScrollView
	}

	/// Header alignment
	func headerAlignment(_ alignment: Alignment) -> ScalingHeader {
		var scalingHeaderScrollView = self
		scalingHeaderScrollView.headerAlignment = alignment
		return scalingHeaderScrollView
	}
}
