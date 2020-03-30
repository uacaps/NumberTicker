//
//  File.swift
//  
//
//  Created by Niklas Fahl on 3/30/20.
//

import SwiftUI

struct NumberComponent: View {
    var numberComponent: NumberComponentsManager.NumberComponent
    var animation: Animation? = .default
    var font: Font
    var topBottomFadeDistance: CGFloat
    
    private var digit: Int?
    private var nonDigit: String?
    
    @Binding var digitFrame: CGSize
    
    init(numberComponent: NumberComponentsManager.NumberComponent,
         animation: Animation? = .default, font: Font,
         topBottomFadeDistance: CGFloat,
         digitFrame: Binding<CGSize>) {
        self.numberComponent = numberComponent
        self.animation = animation
        self.font = font
        self.topBottomFadeDistance = topBottomFadeDistance
        self._digitFrame = digitFrame
        
        digit = getDigit(from: numberComponent)
        nonDigit = getNonDigit(from: numberComponent)
    }
    
    var body: some View {
        Group {
            if digit != nil {
                NumberWheel(visibleNumber: digit!, animation: self.animation, font: self.font, frame: self.$digitFrame)
            } else if nonDigit != nil {
                NumberStyleAccessory(symbol: nonDigit!, font: self.font)
                    .animation(.none)
            }
        }
    }
}

extension NumberComponent {
    // NOTE: These functions are used as a workaround because control flows like switch or if let are not available in view builder yet
    
    func getDigit(from numberComponent: NumberComponentsManager.NumberComponent) -> Int? {
        if case NumberComponentsManager.NumberComponent.digit(let digit) = numberComponent {
            return digit
        }
        return nil
    }
    
    func getNonDigit(from numberComponent: NumberComponentsManager.NumberComponent) -> String? {
        if case NumberComponentsManager.NumberComponent.nonDigit(let separator) = numberComponent {
            return separator
        }
        return nil
    }
}
