//
//  NumberWheel.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

internal struct NumberWheel: View {
    public var visibleNumber: Int = 0
    public var animation: Animation? = .default
    public var font: Font
    
    private let numbers = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    
    @Binding public var frame: CGSize
    @State private var shouldShowActualOffset = false
    
    private func offset() -> CGFloat {
        let offsetMultiplier = 4.5 - Double(shouldShowActualOffset ? visibleNumber : 0)
        let height = frame.height
        return CGFloat(-Double(height) * offsetMultiplier)
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            ForEach(self.numbers, id: \.self) { number in
                SingleNumberElement(number: number, font: self.font, frame: self.$frame)
            }
        }
        .frame(width: frame.width, height: frame.height)
        .offset(y: self.offset())
        .clipped()
        .animation(animation)
        .onAppear {
            self.shouldShowActualOffset = true
        }
    }
}
