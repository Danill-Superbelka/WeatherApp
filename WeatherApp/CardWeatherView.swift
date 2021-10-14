//
//  CardWeatherView.swift
//  WeatherApp
//
//  Created by Даниил  on 14.10.2021.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI


struct CardModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
    }
}


