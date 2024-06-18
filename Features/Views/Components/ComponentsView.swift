//
//  ComponentsView.swift
//  Vintrace
//
//  Created by Wael Saad on 26/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct ComponentsView: View {
    
    @StateObject var viewModel: ComponentsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        contentView
    }
    
    private var contentView: some View {
        VStack(alignment: .leading, spacing: UI.Space.x20) {
            header
            CardView {
                sectionView
            }
            .background(Color.background)
        }
    }
    
    private var header: some View {
        HStack(spacing: UI.Space.x5) {
            Text(Content.header)
                .textCase(nil)
                .foregroundColor(.black)
                .font(.montserrat.bold(size: UI.FontSize.sectionHeader))
            Text(viewModel.componentsCount)
                .foregroundColor(.Text.Component.count)
                .font(.montserrat.light(size: UI.FontSize.componentCount))
            Spacer()
        }
        .padding(.horizontal, UI.Padding.HeaderView.horizontal)
    }
    
    private var sectionView: some View {
        VStack(spacing: 3) {
            let components = viewModel.components
            ForEach(components.indices, id: \.self) { index in
                let component = components[index]
                NavLinkRow(
                    title: component.code,
                    subTitle: component.description,
                    trailingText: component.displayUnit,
                    position: Position.calculate(index: index, totalItems: components.count)
                ) {
                    NavigationView {
                        StockItemScene(viewModel: .init(itemId: component.itemId))
                    }
                    .navigationBarHidden(true)
                    // .navigationViewStyle(.stack)
                    .navigationBarBackButtonHidden(true)
                }
                .frame(height: UI.Dimensions.Component.rowHeight)
            }
        }
    }
    
}

struct ComponentsView_Previews: PreviewProvider {
    static var previews: some View {
        if let stockItem = StockItem.decode(fileName: FileName.stockItem1.value) {
            ComponentsView(viewModel: .init(stockItem: stockItem))
        } else {
            Text(GlobalContent.failedToLoad)
        }
    }
}
