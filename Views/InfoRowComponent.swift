//
//  InfoRowComponent.swift
//  SwapiSwiftApp
//
//  Created by Jesus Mora on 12/6/23.
//

import SwiftUI

struct InfoRowComponent: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.brown)
            
            
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
            
        }
    }
}

