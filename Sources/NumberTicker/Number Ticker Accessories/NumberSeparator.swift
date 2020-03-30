//
//  File.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

struct NumberStyleAccessory: View {
    var symbol: String
    var font: Font
    
    var body: some View {
        Text(symbol)
            .font(font)
            .padding([.leading, .trailing], 1)
    }
}
