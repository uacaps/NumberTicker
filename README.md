# NumberTicker

A rotating number component inspired by [Robinhood](https://github.com/robinhood) written in SwiftUI.

![alt text](https://raw.githubusercontent.com/fahlout/Resources/master/NumberTickerDemo.GIF "Number Ticker Demo")


## Requirements
|Operating System|Version|
|----------------|:-----:|
|iOS             |13+    |
|tvOS            |13+    |
|watchOS         |6+     |
|macOS           |10.15+ |

## Installation

`NumberTicker` is available via [Swift Package Manager](https://swift.org/package-manager).

Using Xcode, go to `File -> Swift Packages -> Add Package Dependency` and enter [https://github.com/fahlout/NumberTicker](https://github.com/fahlout/NumberTicker)

## Usage

To get started all you need to do is initialize NumberTicker with a number.
```swift
NumberTicker(number: 1234.56)
```

There are several ways to customize NumberTicker to work best for your app. 

**1. Font**
```swift
// The font as well as the padding described in a later step contribute to the sizing of the NumberTicker.
// Default: .system(size: 30, weight: .bold, design: .rounded)
NumberTicker(..., font: .system(size: 30, weight: .bold, design: .rounded), ...)
```

**2. Decimal Places**
```swift
// This will effect how many decimal places will be shown in the NumberTicker.
// Default: 0
NumberTicker(..., decimalPlaces: 5, ...)
```

**3. Number Style**
```swift
// This changes how the number is formatted based on a NumberFormatter.Style.
// Default: .none
NumberTicker(..., numberStyle: .currency, ...)
```

**4. Locale**
```swift
// This changes how the number is styled based on the provided Locale.
// Default: .autoupdatingCurrent
NumberTicker(..., locale: Locale("de_DE"), ...)
```

**5. Prefix/Suffix**
```swift
// This adds a prefix and/or suffix to the NumberTicker. This can be any String.
// Default: ""
NumberTicker(..., prefix: "~", suffix: "Quarters", ...)
```

**6. Initial Animation**
```swift
// This changes whether or not it will animate to the number when it initially appears on screen.
// Default: false
NumberTicker(..., shouldAnimateToInitialNumber: true, ...)
```

**7. Extra Padding**
```swift
// This changes how much extra padding the NumberTicker should have on the top and bottom. This also affects how the fade will look descriped in a later step.
// Default: 0
NumberTicker(..., topBottomPadding: 5, ...)
```

**8. Fade Color**
```swift
// This changes the color of the top and bottom fade. The fade will only show if the color is set and topBottomPadding is greater than 0. To make the fade blend into the background of the view it's displayed on set this color to the background color of the view it's displayed on.
// Default: nil
NumberTicker(..., fadeColor: .red, ...)
```

## Author
👨‍💻 [Niklas Fahl](https://github.com/fahlout)

## License
NumberTicker is available under the University of Alabama License. See the [LICENSE](https://github.com/fahlout/NumberTicker/blob/master/LICENSE) file for more info.
