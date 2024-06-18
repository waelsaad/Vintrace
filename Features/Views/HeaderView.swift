//
//  HeaderView.swift
//  Vintrace
//
//  Created by Wael Saad on 25/2/2024.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    
    @State var stockItem: StockItem
     
     var body: some View {
         CardView { contentView }
     }
     
    private var contentView: some View {
        VStack(alignment: .leading, spacing: 0) {
            description
                .padding(.bottom, UI.Padding.Description.bottom)
            secondaryDescription
                .padding(.bottom, UI.Padding.SecondaryDescription.bottom)

            HStack(spacing: UI.Padding.spaceBetweenIconAndText) {
                colour
                beverageProperties
            }
            .padding(.bottom, UI.Padding.BeverageProperties.bottom)
            
            VStack(alignment: .leading, spacing: UI.Space.x5) {
                labelText(stockItem.owner.name, image: .user)
                labelText(stockItem.unit.name, image: .measuring_cup)
            }
        }
        .align(.leading)
        .padding(.top, UI.Padding.HeaderView.top)
        // .padding(.bottom, UI.Padding.HeaderView.bottom)
        .padding(.leading, UI.Padding.HeaderView.leading)
    }
    
    @ViewBuilder
     private var description: some View {
         Text(stockItem.description)
             .foregroundColor(.Text.Item.darkGray)
             .font(.montserrat.light(size: UI.FontSize.description))
     }
     
    @ViewBuilder
     private var secondaryDescription: some View {
         if let text = stockItem.secondaryDescription {
             Text(text)
                 .foregroundColor(.Text.Item.secondaryDescription)
                 .font(.montserrat.regular(size: UI.FontSize.secondaryDescription))
         }
     }
     
    @ViewBuilder
     private var beverageProperties: some View {
         if let text = stockItem.beverageProperties?.description {
             Text(text)
                 .foregroundColor(.Text.Item.darkGray)
                 .font(.montserrat.regular(size: UI.FontSize.secondaryDescription))
         }
     }
     
    @ViewBuilder
     private var colour: some View {
         if let colour = stockItem.beverageProperties?.colour {
             Circle()
                 .foregroundColor(colour)
                 .frame(size: UI.Dimensions.circleRadius)
         }
     }
     
    @ViewBuilder
     private func labelText(_ text: String?, image: AppImage) -> some View {
         if let text = text {
             HStack(spacing: UI.Padding.spaceBetweenIconAndText) {
                 Image(appImage: image)
                     .resizable()
                     .aspectRatio(contentMode: .fill)
                     .frame(size: UI.ImageSize.itemIcon)
                 Text(text)
                     .foregroundColor(.Text.Item.darkGray)
                     .font(.montserrat.light(size: UI.FontSize.name))
             }
         }
     }
    
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        if let stockItem = StockItem.decode(fileName: FileName.stockItem1.value) {
            HeaderView(stockItem: stockItem)
        } else {
            Text(GlobalContent.failedToLoad)
        }
    }
}
