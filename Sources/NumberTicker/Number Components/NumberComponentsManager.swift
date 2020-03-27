//
//  File.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import Foundation

struct NumberComponentsManager {
    private typealias DigitsConvertible = Numeric & LosslessStringConvertible
    
    func components(for number: Double, decimalPlaces: Int) -> [Int] {
        guard decimalPlaces > 0 else {
            return digits(for: Int(round(number)))
        }
        
        // Make sure floating point precision is not messing up the displayed number, i.e. 12.999999999991 should be displayed as 13.00 instead of 12.99; 12.989999999991 should be displayed as 12.99 instead of 12.98 if decimal places are set to 2
        let decimalRoundingAccuracy: Double = pow(10, Double(decimalPlaces))
        let roundedNumber = round(number * decimalRoundingAccuracy) / decimalRoundingAccuracy
        let integerPartDigits = digits(for: Int(roundedNumber))
        
        let decimalPartAsInteger = Int(round(roundedNumber.truncatingRemainder(dividingBy: 1) * decimalRoundingAccuracy))
        var decimalDigits = digits(for: decimalPartAsInteger)
        if decimalPlaces - decimalDigits.count > 0 {
            decimalDigits = Array(repeating: 0, count: decimalPlaces - decimalDigits.count) + decimalDigits // Pad decimals up to desired length
        }
        
        return integerPartDigits + decimalDigits
    }
    
    private func digits<T: DigitsConvertible>(for number: T) -> [Int] {
        String(number).compactMap{ $0.wholeNumberValue }
    }
}
