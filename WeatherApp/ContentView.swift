//
//  ContentView.swift
//  WeatherApp
//
//  Created by Даниил  on 30.09.2021.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @State private var location = " "
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Город", text: $location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button{
                        getWeatherForecast(for: location)
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
            .navigationTitle("Погода")
            
        }
    }
    
    func getWeatherForecast(for location: String) {
        let apiService = APIService.shared
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        CLGeocoder().geocodeAddressString("Paris") {placemarks, error} in
        if let error = error {
            print(error.localizedDescription)
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
