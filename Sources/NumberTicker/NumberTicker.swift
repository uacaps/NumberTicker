//
//  NumberTicker.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

public struct NumberTicker: View {
    // User initialized properties
    private var prefix: String
    private var suffix: String
    private var shouldAnimateToInitialNumber: Bool
    private var font: Font
    private var topBottomPadding: CGFloat
    private var widthMultiplier: CGFloat
    private var fadeColor: Color?
    
    // Properties used for view rendering
    private var numberComponentsManager = NumberComponentsManager()
    private var animation: Animation? {
        shouldAnimate ? Animation.interpolatingSpring(stiffness: 8, damping: 8, initialVelocity: 2).speed(6) : .none
    }
    private var shouldShowFade: Bool {
        topBottomPadding >= 0 && fadeColor != nil
    }
    
    @State private var shouldAnimate = false
    @State private var digitFrame: CGSize = .zero
    
    /// Initialize NumberTicker with your desired customization options.
    ///
    /// - Parameters:
    ///   - number: The number to be displayed.
    ///   - decimalPlaces: The number of decimal places to be displayed for the number. Defaults to 0.
    ///   - numberStyle: The style for the number to be displayed in based on NumberFormatter.Style. Defaults to .none.
    ///   - locale: The locale used for formatting the number. Defaults to .autoupdatingCurrent.
    ///   - prefix: The prefix to be added to the displayed number. Defaults to empty string.
    ///   - suffix: The suffic to be added to the displayed number. Defaults to empty string.
    ///   - shouldAnimateToInitialNumber: Whether or not the NumberTicker should animate to the initial number that is set when NumberTicker first appears. Defaults to false.
    ///   - font: The font used for the number as well as prefix and suffix. This directly impacts the size of the NumberTicker.
    ///   - topBottomPadding: Extra padding for the top and bottom of the NumberTicker. This increases the amount of space between each digit in each number column and directly impacts the overall sizing of the NumberTicker.
    ///   - fadeColor: The color used to add a gradient fade to the top and bottom of the NumberTicker. Note: Fade effect will only show if both the fadeColor is set and topBottomPadding is greater than 0.
    public init(number: Double,
                decimalPlaces: Int = 0,
                numberStyle: NumberFormatter.Style = .none,
                locale: Locale = .autoupdatingCurrent,
                prefix: String = "",
                suffix: String = "",
                shouldAnimateToInitialNumber: Bool = false,
                font: Font = .system(size: 30, weight: .bold, design: .rounded),
                topBottomPadding: CGFloat = 0,
                widthMultiplier: CGFloat = 1,
                fadeColor: Color? = nil) {
        self.prefix = prefix
        self.suffix = suffix
        self.shouldAnimateToInitialNumber = shouldAnimateToInitialNumber
        self.font = font
        self.topBottomPadding = topBottomPadding
        self.widthMultiplier = widthMultiplier
        self.fadeColor = fadeColor
        
        numberComponentsManager.setup(for: number, decimalPlaces: decimalPlaces, numberStyle: numberStyle, locale: locale)
    }

    public var body: some View {
        HStack(spacing: 0) {
            if !prefix.isEmpty {
                NumberAccessory(text: prefix, style: .prefix, font: font)
                    .animation(.none)
            }
            ForEach(0..<numberComponentsManager.numberComponents.count, id: \.self) { index in
                HStack(spacing: 0) {
                    NumberComponent(numberComponent: self.numberComponentsManager.getNumberComponent(at: index), animation: self.animation, font: self.font, digitFrame: self.$digitFrame)
                }
            }
            if !suffix.isEmpty {
                NumberAccessory(text: suffix, style: .suffix, font: font)
                    .animation(.none)
            }
        }
        .overlay(shouldShowFade ? FadeOverlay(height: topBottomPadding * 1.5, color: fadeColor!) : nil)
        .overlay(TextSizingCalculationOverlayView(text: "0", font: font, topBottomPadding: topBottomPadding, widthMultiplier: widthMultiplier, frame: $digitFrame))
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
