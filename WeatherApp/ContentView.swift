//
//  ContentView.swift
//  WeatherApp
//
//  Created by Даниил  on 30.09.2021.
//

import SwiftUI

struct ContentView: View {
    let weather = APIService()
    
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
