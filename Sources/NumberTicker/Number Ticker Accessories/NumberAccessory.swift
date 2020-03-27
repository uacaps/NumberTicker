//
//  File.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

struct NumberAccessory: View {
    enum Style {
        case prefix
        case suffix
    }
    
    var text: String
    var style: Style
    var font: Font
    
    private var paddingEdge: Edge.Set {
        switch style {
        case .prefix:
            return .trailing
        case .suffix:
            return .leading
        }
    }
    
    var body: some View {
        Text(text)
            .font(font)
            .padding(paddingEdge, 2)
    }
}
