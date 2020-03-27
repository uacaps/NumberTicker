//
//  ContentView.swift
//  NumberTickerExample
//
//  Created by Niklas Fahl on 3/27/20.
//  Copyright © 2020 Nik Fahl. All rights reserved.
//

import SwiftUI
import NumberTicker

extension FloatingPoint {
  var isInteger: Bool { rounded() == self }
}

struct ContentView: View {
    @State var currentNumber = 150000.0
    
    var body: some View {
        VStack(alignment: .leading) {
            NumberTicker(number: currentNumber * 0.84025, prefix: "£", font: Font.system(size: 25, weight: .medium, design: .serif))
                .foregroundColor(Color(.secondaryLabel))
                .padding(.bottom, 5)
            NumberTicker(number: currentNumber * 0.920078, suffix: "€", decimalSeparator: ",", thousandsSeparator: ".", font: Font.system(size: 25, weight: .medium, design: .serif)) // German Style
                .foregroundColor(Color(.secondaryLabel))
                .padding(.bottom, 15)
            NumberTicker(number: currentNumber, prefix: "US $") // US Style
            NumberTicker(number: currentNumber * 4, decimalPlaces: 0, prefix: (currentNumber * 4).isInteger ? "" : "~", suffix: currentNumber * 4 == 1 ? " Quarter" : " Quarters", font: Font.system(size: 20, weight: .medium))
                .foregroundColor(Color(.secondaryLabel))
                .padding(.bottom, 80)
            
            Stepper(value: $currentNumber, in: 0...1050000, step: 5.25) {
                Text("\(currentNumber)")
            }
            Slider(value: $currentNumber, in: 0...1050000, step: 0.01)
            Text("Number reference: \(currentNumber)")
        }
        .padding(25)
        .onAppear {
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
