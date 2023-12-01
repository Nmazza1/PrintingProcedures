//
//  RectangleButton.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-16.
//

import SwiftUI

struct RectangleButton: View {
    var buttonText: String
    var body: some View {
        Rectangle()
            .rectangleModifier()
            .overlay(
            Text(buttonText)
                .font(.custom("JetBrainsMono-Regular", size: 20))
                .foregroundColor(.white)
            
            )
            .border(.black)
    }
}

struct RectangleButton_Previews: PreviewProvider {
    static var previews: some View {
        RectangleButton(buttonText: "Default Text")
    }
}
