//
//  AppButton.swift
//  SaudiMarch
//
//  Created by MacBook pro on 20/09/2022.
//

import Foundation
import SwiftUI

struct AppButton: View {
    
    init(text: String, width: CGFloat, height: CGFloat, backgroundColor: Color, textColor: Color = .white, cornerRadius: CGFloat = 0, borderColor: Color = .clear, borderWidth: CGFloat = 0, action: @escaping () -> ()) {
        self.text = text
        self.width = width
        self.height = height
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.cornerRadius = cornerRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.action = action
    }
    
    
    let text: String
    let width: CGFloat
    let height: CGFloat
    let backgroundColor: Color
    let textColor: Color
    
    let cornerRadius: CGFloat
    let borderColor: Color
    let borderWidth: CGFloat
    
    var action: () -> ()
    
    var body: some View {
        Button(action: {
            self.action()
        }) {
            Text(text)
                .foregroundColor(textColor)
                .frame(width: width + cornerRadius)
                .frame(height: height)
        }
        .background(backgroundColor)
        .buttonStyle(.borderless)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
                .buttonStyle(.borderless)
                .background(.clear)
                .clipped()
        )
        .cornerRadius(cornerRadius)
    }
}
