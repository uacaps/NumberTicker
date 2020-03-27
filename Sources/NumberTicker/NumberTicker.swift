//
//  File.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

public struct NumberTicker: View {
    // User initialized properties
    private var number: Double
    private var decimalPlaces: Int
    private var prefix: String
    private var suffix: String
    private var decimalSeparator: String
    private var thousandsSeparator: String
    private var shouldAnimateToInitialNumber: Bool
    private var font: Font
    private var topBottomFadeDistance: CGFloat
    private var fadeColor: Color
    
    // Properties used for view rendering
    private let numberComponentsManager = NumberComponentsManager()
    private var numberComponents: [Int] = []
    private var animation: Animation? {
        shouldAnimate ? Animation.interpolatingSpring(stiffness: 8, damping: 8, initialVelocity: 2).speed(6) : .none
    }
    
    @State private var shouldAnimate = false
    @State private var numberFrame: CGSize = .zero
    @State private var decimalSeparatorFrame: CGSize = .zero
    @State private var thousandsSeparatorFrame: CGSize = .zero
    
    public init(number: Double, decimalPlaces: Int = 2, prefix: String = "", suffix: String = "", decimalSeparator: String = ".", thousandsSeparator: String = ",", shouldAnimateToInitialNumber: Bool = false, font: Font = .system(size: 30, weight: .bold, design: .rounded), topBottomFadeDistance: CGFloat = 3, fadeColor: Color = Color(.systemBackground)) {
        self.number = number
        self.decimalPlaces = decimalPlaces
        self.prefix = prefix
        self.suffix = suffix
        self.decimalSeparator = decimalSeparator
        self.thousandsSeparator = thousandsSeparator
        self.shouldAnimateToInitialNumber = shouldAnimateToInitialNumber
        self.font = font
        self.topBottomFadeDistance = topBottomFadeDistance
        self.fadeColor = fadeColor
        
        numberComponents = numberComponentsManager.components(for: number, decimalPlaces: decimalPlaces).reversed()
    }

    public var body: some View {
        HStack(spacing: 0) {
            if !prefix.isEmpty {
                NumberAccessory(text: prefix, style: .prefix, font: font)
                    .animation(.none)
            }
            ForEach((0..<numberComponents.count).reversed(), id: \.self) { index in
                HStack(spacing: 0) {
                    if self.shouldInsertDecimalSeparator(at: index) {
                        NumberSeparator(symbol: self.decimalSeparator, font: self.font, frame: self.$decimalSeparatorFrame)
                            .animation(.none)
                    } else if self.shouldInsertThousandsSeparator(at: index) {
                        NumberSeparator(symbol: self.thousandsSeparator, font: self.font, frame: self.$thousandsSeparatorFrame)
                            .animation(.none)
                    }
                    NumberWheel(visibleNumber: self.getNumberComponent(at: index), animation: self.animation, font: self.font, frame: self.$numberFrame)
                }
            }
            if !suffix.isEmpty {
                NumberAccessory(text: suffix, style: .suffix, font: font)
                    .animation(.none)
            }
        }
        .overlay(FadeOverlay(height: topBottomFadeDistance * 1.5, color: fadeColor))
        .overlay(TextSizingCalculationOverlayView(text: "0", font: font, topBottomPadding: topBottomFadeDistance, frame: $numberFrame))
        .overlay(TextSizingCalculationOverlayView(text: decimalSeparator, font: font, topBottomPadding: topBottomFadeDistance, frame: $decimalSeparatorFrame))
        .overlay(TextSizingCalculationOverlayView(text: thousandsSeparator, font: font, topBottomPadding: topBottomFadeDistance, frame: $thousandsSeparatorFrame))
        .animation(animation)
        .onAppear {
            self.shouldAnimate = self.shouldAnimateToInitialNumber
            
            // This delay could cause issues if number is set again within 0.3 seconds of this view appearing on screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.shouldAnimate = true
            }
        }
    }
}

extension NumberTicker {
    private func getNumberComponent(at index: Int) -> Int {
        if index < numberComponents.count {
            return numberComponents[index]
        }
        return 0
    }
    
    private func shouldInsertThousandsSeparator(at index: Int) -> Bool {
        index != numberComponents.count - 1 && index >= decimalPlaces + 2 && (numberComponents.count - decimalPlaces) > 3 && (index - decimalPlaces + 1) % 3 == 0
    }
    
    private func shouldInsertDecimalSeparator(at index: Int) -> Bool {
        numberComponents.count > 2 && index == decimalPlaces - 1
    }
}
