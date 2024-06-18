//
//  LevelsView.swift
//  Vintrace
//
//  Created by Wael Saad on 26/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct LevelsView: View {
    
    @StateObject var viewModel: LevelsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        VStack(spacing: UI.Space.x20) {
            header
            CardView {
                sectionView
            }
            .background(Color.background)
        }
    }
    
    private var header: some View {
        HStack {
            Text(Content.header)
                .textCase(nil)
                .foregroundColor(.black)
                .font(.montserrat.bold(size: UI.FontSize.sectionHeader))
            Spacer()
            editButton
        }
        .padding(.horizontal, UI.Padding.HeaderView.horizontal)
    }
    
    private var sectionView: some View {
        VStack(spacing: 3) {
            ForEach(Array(viewModel.levels.enumerated()), id: \.1.label) { index, level in
                VStack {
                    HStack {
                        labelView(for: level)
                        Spacer()
                        valueView(for: level)
                    }
                    .padding(.horizontal, 15)
                    .frame(height: UI.Dimensions.Level.rowHeight)
                    if index != viewModel.levels.count - 1 {
                        Color.navLinkDivider.frame(height: 3).opacity(0.4)
                    }
                }
                .background(Color.white)
            }
        }
    }

    private func labelView(for level: LevelsViewModel.Level) -> some View {
        Text(level.label)
            .foregroundColor(.Text.Item.levelLabel)
            .font(.montserrat.regular(size: UI.FontSize.level))
    }

    private func valueView(for level: LevelsViewModel.Level) -> some View {
        Text(level.value)
            .foregroundColor(viewModel.getTextColor(for: level))
            .font(.montserrat.regular(size: UI.FontSize.level))
    }
    
    private var editButton: some View {
        Button {
            viewModel.showAlert = true
        } label: {
            Text(GlobalContent.editTitle)
                .textCase(nil)
                .foregroundColor(.Text.Item.edit)
                .font(.montserrat.light(size: UI.FontSize.listButton))
        }
        .clipShape(Rectangle())
        .foregroundColor(.Text.Item.edit)
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
    
}

struct LevelsView_Previews: PreviewProvider {
    static var previews: some View {
        if let stockItem = StockItem.decode(fileName: FileName.stockItem1.value) {
            LevelsView(viewModel: .init(stockItem: stockItem))
        } else {
            Text(GlobalContent.failedToLoad)
        }
    }
}
