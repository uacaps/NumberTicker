//
//  NumberStyleAccessory.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

internal struct NumberStyleAccessory: View {
    public var symbol: String
    public var font: Font
    
    public var body: some View {
        Text(symbol)
            .font(font)
            .padding([.leading, .trailing], 1)
    }
}
