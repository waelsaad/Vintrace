//
//  StockItemScene.swift
//  Vintrace
//
//  Created by Wael Saad on 25/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct StockItemScene: View {
    
    @StateObject var viewModel: StockItemViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    @State var progress: CGFloat = 0
    
    var body: some View {
        ZStack {
            mainView
        }
        .navigationViewStyle(.stack)
        .background(Color.background)
    }
    
    var mainView: some View {
        ZStack {
            layoutView
            topButtons
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    private var layoutView: some View {
        ZStack {
            ScalingHeader {
                headerView
            } fixedView: {
                title
            } content: {
                contentView
            }
            .height(min: UI.Dimensions.minHeight, max: UI.Dimensions.maxHeight)
            .collapseProgress($progress)
            
            // you may uncomment this to see a different behaviour to make the hero shot grow. You may like it :]
            .allowsHeaderGrowth()
            
            .allowsHeaderCollapse()
        }
    }
    
    private var headerView: some View {
        ZStack {
            Color.accentColor
                .edgesIgnoringSafeArea(.all)
            fullView(progress: progress)
        }
    }
    
    private var miniView: some View {
        HStack(spacing: 0) {
            if let code = viewModel.stockItem?.code {
                Text(code)
                    .foregroundColor(.white)
                    .font(.montserrat.regular(size: UI.FontSize.titleInNavigation))
            }
        }
    }
    
    private func fullView(progress: CGFloat) -> some View {
        ZStack(alignment: .leading) {
            if let images = viewModel.stockItem?.imageNames {
                CarouselView(images: images, defaultImage: .generic)
                    .opacity(1 - progress)
            }
            VStack {
                Spacer()
                miniView
                    .opacity(progress)
                    .padding(.leading, UI.Padding.titleLeading)
                    .frame(height: UI.Dimensions.miniHeaderHeight)
                    .opacity(max(0, min(1, (progress - 0.75) * 4.0)))
            }
        }
    }
    
    @ViewBuilder
    private var contentView: some View {
        if let stockItem = viewModel.stockItem {
            VStack(spacing: UI.Space.ContentView.vertical) {
                HeaderView(stockItem: stockItem)
                LevelsView(viewModel: .init(stockItem: stockItem))
                if !stockItem.components.isEmpty {
                    ComponentsView(viewModel: .init(stockItem: stockItem))
                }
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private var title: some View {
        if let text = viewModel.stockItem?.code {
            Text(text)
                .offset(y: UI.Padding.Title.yOffset)
                .padding(.leading, UI.Padding.Title.leading)
                .font(.montserrat.semibold(size: UI.FontSize.title))
                .foregroundColor(.Text.Item.title)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .opacity(1 - max(0, min(1, (progress - 0.75) * 4.0)))
        }
    }

    // MARK: ToolBar Buttons
    
    private var topButtons: some View {
        VStack {
            HStack {
                backButton
                Spacer()
                trailingButtons
            }
            .padding(.horizontal)
            .padding(.top, UI.Padding.topBarTop)
            Spacer()
        }
        .ignoresSafeArea()
    }
    
    private var backButton: some View {
        Button {
            dismiss()
        }
        .backStyle(progress: progress)
    }
    
    private var editButton: some View {
        Button {
            viewModel.showAlert = true
        }
        .editStyle(progress: progress)
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text(Content.alertTitle),
                message: Text(Content.alertMessage),
                dismissButton: .default(Text(Content.alertButtonTitle)) {
                    viewModel.showAlert = false
                }
            )
        }
    }
    
    private var moreButton: some View {
        Button {
            viewModel.showBrowser = true
        }
        .moreStyle(progress: progress)
        .fullSafariBrowser(url: viewModel.url, isPresented: $viewModel.showBrowser)
    }
    
    private var trailingButtons: some View {
        HStack(spacing: 5) {
            editButton
            moreButton
        }
    }
    
}

struct StockItemScene_Previews: PreviewProvider {
    static var previews: some View {
        StockItemScene(viewModel: .init(itemId: 1))
    }
}
