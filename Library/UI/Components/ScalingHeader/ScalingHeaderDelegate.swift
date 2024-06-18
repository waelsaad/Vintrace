//
//  ScalingHeaderDelegate.swift
//  Library
//
//  Created by Wael Saad on 10/8/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import UIKit

final class ScalingHeaderDelegate: NSObject, ObservableObject, UIScrollViewDelegate {

	var didPullToRefresh: () -> Void = { }
	var didPullToLoadMore: () -> Void = { }
	var didScroll: () -> Void = {}
	var didEndDragging = {}
	var didEndDecelerating = {}
	var willEndDragging: (Double) -> Void = { _ in }

	// MARK: - UIScrollViewDelegate

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		didScroll()
	}

	func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		willEndDragging(velocity.y)
	}

	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		if scrollView.contentOffset.y < -60 {
			didPullToRefresh()
		}
		let maxYOffset = scrollView.contentSize.height - scrollView.bounds.height
		if scrollView.contentOffset.y > maxYOffset + 60 {
			didPullToLoadMore()
		}

		didEndDragging()
	}

	func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		didEndDragging()
	}

	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		didEndDecelerating()
	}
}
enum SnapHeaderState: Equatable {
	case expanded
	case collapsed
	case custom(CGFloat)
}

enum SnapHeaderMode: Int {
	/// Disable header snap.
	case disabled

	/// Enable header snap.
	/// Once you lift your finger header snaps either to min or max height automatically.
	case immediately

	/// Enable header snap. Smoother scroll mode.
	/// At the end of scroll view deceleration the header snaps either to min or max height automatically.
	case afterFinishAccelerating
}
