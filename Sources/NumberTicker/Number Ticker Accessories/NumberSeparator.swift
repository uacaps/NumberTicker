//
//  File.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

struct NumberSeparator: View {
    var symbol: String
    var font: Font
    @Binding var frame: CGSize
    
    var body: some View {
        Text(symbol)
            .font(font)
            .frame(width: frame.width, height: frame.height)
    }
}
