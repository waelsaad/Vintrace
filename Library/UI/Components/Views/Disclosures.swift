//
//  Disclosures.swift
//  Library
//
//  Created by Wael Saad on 19/7/2022.
//  Copyright © 2022 NetTrinity. All rights reserved.
//

import SwiftUI

struct DisclosureInfo: Identifiable {
    var id: String { heading.value }
    let heading: LocalizedStringKey
    let content: LocalizedStringKey
}

struct DisclosureIndicator: View {
    
    var body: some View {
        Image(systemImage: .rightChevron)
            .font(Font.system(.footnote).weight(.bold))
            .foregroundColor(.disclosureIndicator)
    }
}
