//
//  ForecastListVM.swift
//  WeatherApp
//
//  Created by Даниил  on 08.10.2021.
//

import Foundation
import CoreLocation
import SwiftUI

class ForecastListVM: ObservableObject {
    
    @Published var forecast: [WeatherForecastDayliVM] = []
    @AppStorage("location") var location = " "
    
    init() {
        if location != "" {
            getWeatherForecast()
        }
    }
    
    func getWeatherForecast() {
        let apiService = APIService.shared
        CLGeocoder().geocodeAddressString(location) { (placemark, error) in
            if let error = error {
                print("Ошибка:", error.localizedDescription)
            }
            if let lat = placemark?.first?.location?.coordinate.latitude,
               let lon = placemark?.first?.location?.coordinate.longitude {
                apiService.getJSON(stringURL: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,alerts&appid=38b4a54648c28f3f6c543eef683881cd") {
                    (result: Result<WeatherForecast, APIService.ApiError>) in
                    switch result {
                    case .success(let forecast):
                        DispatchQueue.main.async {
                            self.forecast = forecast.daily.map {WeatherForecastDayliVM(forecast: $0)}
                        }
                    case .failure(let apiError):
                        print(apiError)
                    }
                }
            }
        }
    }
    
}
