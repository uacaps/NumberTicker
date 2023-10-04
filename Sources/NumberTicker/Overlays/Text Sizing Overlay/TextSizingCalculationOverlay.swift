//
//  TextSizingCalculationOverlayView.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

internal struct TextSizingCalculationOverlayView: View {
    public var text: String
    public var font: Font
    public var topBottomPadding: CGFloat = 0
    public var widthMultiplier: CGFloat
    
    @Binding public var frame: CGSize
    
    private func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.frame = CGSize(width: geometry.size.width * widthMultiplier, height: geometry.size.height + (self.topBottomPadding * 2))
        }
        return Text(text)
            .font(font)
    }
    
    public var body: some View {
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
