//
//  File.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

struct SingleNumberElement: View {
    var number: Int = 0
    var font: Font
    @Binding var frame: CGSize
    
    var body: some View {
        Text("\(self.number)")
            .font(font)
            .frame(width: frame.width, height: frame.height)
    }
}
