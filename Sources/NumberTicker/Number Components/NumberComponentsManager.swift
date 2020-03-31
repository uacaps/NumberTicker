//
//  NumberComponentsManager.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import Foundation

internal class NumberComponentsManager {
    private typealias DigitsConvertible = Numeric & LosslessStringConvertible
    
    public enum NumberComponent: Equatable {
        case nonDigit(String)
        case digit(Int)
    }
    
    public private(set) var numberComponents: [NumberComponent] = []
    private var number: Double = 0
    private var decimalPlaces: Int = 2
    private let numberFormatter = NumberFormatter()
    
    public func setup(for number: Double,
               decimalPlaces: Int,
               numberStyle: NumberFormatter.Style = .decimal,
               locale: Locale = .autoupdatingCurrent) {
        self.number = number
        self.decimalPlaces = decimalPlaces
        
        self.numberFormatter.minimumFractionDigits = decimalPlaces
        self.numberFormatter.maximumFractionDigits = decimalPlaces
        self.numberFormatter.numberStyle = numberStyle
        self.numberFormatter.locale = locale
        
        numberComponents = components(for: number, decimalPlaces: decimalPlaces, formatter: numberFormatter)
    }
}

extension NumberComponentsManager {
    public func getNumberComponent(at index: Int) -> NumberComponent {
        if index < numberComponents.count {
            return numberComponents[index]
        }
        return .digit(0)
    }
}

extension NumberComponentsManager {
    public func components(for number: Double, decimalPlaces: Int, formatter: NumberFormatter) -> [NumberComponent] {
        guard let formattedNumberString = formatter.string(from: NSNumber(value: number)) else { return [] }
        return formattedNumberString.compactMap {
            if let digit = $0.wholeNumberValue {
                return .digit(digit)
            } else {
                return .nonDigit(String($0))
            }
        }
    }
}
