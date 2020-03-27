//
//  File.swift
//  
//
//  Created by Niklas Fahl on 3/27/20.
//

import SwiftUI

struct FadeOverlay: View {
    var height: CGFloat
    var color: Color
    
    var body: some View {
        VStack {
            LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.0)]), startPoint: .top, endPoint: .bottom)
                .frame(height: height)
            Spacer()
            LinearGradient(gradient: Gradient(colors: [color, color.opacity(0.0)]), startPoint: .bottom, endPoint: .top)
                .frame(height: height)
        }
    }
}
