//
//  StylesAndModifiers.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-30.
//

import Foundation
import SwiftUI

struct ElementViewLabel: LabelStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack{
            configuration.title
        }
        .font(.custom("JetBrainsMono-Regular", size: 30))
    }
}

struct rectangleBox: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.clear)
            .frame(width: 287, height: 49)
            .background(Color(.systemGray))
            .shadow(color: .black.opacity(0.25), radius: 3.5,
                    x: 3, y: 9)
            
    }
}
extension View {
    func rectangleModifier() -> some View {
        modifier(rectangleBox())
    }
}
