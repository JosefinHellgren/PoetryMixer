//
//  BlackButtonRoundedRectangle.swift
//  WeatherPoetry
//
//  Created by josefin hellgren on 2023-11-13.
//

import Foundation
import SwiftUI

struct BlackBackgroundButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        
            .padding()
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(8)
    }
}
