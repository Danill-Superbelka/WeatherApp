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
        CLGeocoder().geocodeAddressString(location) { (placemark, error) in
            if let error = error {
                print("Ошибка:", error.localizedDescription)
            }
            if let lat = placemark?.first?.location?.coordinate.latitude,
               let lon = placemark?.first?.location?.coordinate.longitude {
                apiService.getJSON(stringURL: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,hourly,alerts&appid=38b4a54648c28f3f6c543eef683881cd") {
                    (result: Result<WeatherForecast, APIService.ApiError>) in
                    switch result {
                    case .success(let forecast):
                        for day in forecast.daily {
                            print(dateFormatter.string(from: day.dt))
                        }
                    case .failure(let apiError):
                        print(apiError)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
