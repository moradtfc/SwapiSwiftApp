//
//  InfoSectionViewComponent.swift
//  SwapiSwiftApp
//
//  Created by Jesus Mora on 12/6/23.
//

import SwiftUI

struct InfoSectionViewComponent: View {
    let infoData: [(String, String)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 16) {
                ForEach(infoData, id: \.0) { (title, value) in
                    InfoRowComponent(title: title, value: value)
                }
            }
        }
    }
}


