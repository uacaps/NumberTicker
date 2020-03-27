//
//  File.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

struct TextSizingCalculationOverlayView: View {
    var text: String
    var font: Font
    var topBottomPadding: CGFloat = 0
    
    @Binding var frame: CGSize
    
    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.frame = CGSize(width: geometry.size.width, height: geometry.size.height + (self.topBottomPadding * 2))
        }
        return Text(text)
            .font(font)
    }
    
    var body: some View {
        VStack {
            Text(text)
                .font(font)
        }.overlay(
            GeometryReader { geometry in
                self.makeView(geometry: geometry)
            }
        )
        .hidden()
    }
}
