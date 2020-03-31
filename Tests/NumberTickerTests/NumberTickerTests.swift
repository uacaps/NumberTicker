import XCTest
@testable import NumberTicker

final class NumberComponentsManagerTests: XCTestCase {
    let numberComponentsManager = NumberComponentsManager()
    
    func testSetup() {
        numberComponentsManager.setup(for: 1, decimalPlaces: 2, numberStyle: .none, locale: Locale(identifier: "en_EN"))
        XCTAssertEqual(numberComponentsManager.numberComponents.count, 4)
        
        numberComponentsManager.setup(for: 1, decimalPlaces: 2, numberStyle: .none, locale: Locale(identifier: "en_EN"))
        XCTAssertNotEqual(numberComponentsManager.numberComponents.count, 3)
        
        numberComponentsManager.setup(for: 1500000.73, decimalPlaces: 3, numberStyle: .decimal, locale: Locale(identifier: "en_US"))
        XCTAssertEqual(numberComponentsManager.numberComponents.count, 13)
        
        numberComponentsManager.setup(for: 1500000.73, decimalPlaces: 0, numberStyle: .decimal, locale: Locale(identifier: "en_US"))
        XCTAssertEqual(numberComponentsManager.numberComponents.count, 9)
    }
    
    func testGetNumberComponentAtIndex() {
        numberComponentsManager.setup(for: 1500000.73, decimalPlaces: 2, numberStyle: .decimal, locale: Locale(identifier: "en_US"))
        XCTAssertEqual(numberComponentsManager.getNumberComponent(at: 2), .digit(5))
        XCTAssertEqual(numberComponentsManager.getNumberComponent(at: 1), .nonDigit(","))
        XCTAssertEqual(numberComponentsManager.getNumberComponent(at: 5), .nonDigit(","))
        XCTAssertEqual(numberComponentsManager.getNumberComponent(at: 8), .digit(0))
        XCTAssertEqual(numberComponentsManager.getNumberComponent(at: 9), .nonDigit("."))
        XCTAssertEqual(numberComponentsManager.getNumberComponent(at: 11), .digit(3))
    }
    
    func testGetComponents() {
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "en_US")
        
        let components = numberComponentsManager.components(for: 1500000.73, decimalPlaces: 2, formatter: numberFormatter)
        let testComponents: [NumberComponentsManager.NumberComponent] = [.digit(1), .nonDigit(","), .digit(5), .digit(0), .digit(0), .nonDigit(","), .digit(0), .digit(0), .digit(0), .nonDigit("."), .digit(7), .digit(3)]
        XCTAssertEqual(components, testComponents)
    }

    static var allTests = [
        ("testSetup", testSetup),
        ("testGetNumberComponentAtIndex", testGetNumberComponentAtIndex),
        ("testGetComponents", testGetComponents)
    ]
}
