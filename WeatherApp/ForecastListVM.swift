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
    struct AppError: Identifiable {
        let id = UUID().uuidString
        let errorString: String
    }
    
    @Published var forecastDay: [WeatherForecastDayliVM] = []
    @Published var forecastHour: [WeatherForecastHourlyVM] = []
    var appError: AppError? = nil
    //@Published var isLoading: Bool = false
    @AppStorage("location") var location = " "
    //@Published var location = ""
    
    init() {
        if location != ""{
            getWeatherForecast()
        }
        //location = storageLocation
        //getWeatherForecast()
    }
    
    func getWeatherForecast() {
        //storageLocation = location
        UIApplication.shared.endEditing()
        if location == "" {
            forecastDay = []
            forecastHour = []
        } else {
           //isLoading = true
            let apiService = APIService.shared
            CLGeocoder().geocodeAddressString(location) { (placemark, error) in
                if let error = error {
                    print("Ошибка \(error.localizedDescription)")
                }
                if let lat = placemark?.first?.location?.coordinate.latitude,
                   let lon = placemark?.first?.location?.coordinate.longitude {
                    print("Hello \(lat) \(lon)")
                    apiService.getJSON(stringURL: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,alerts&appid=*********************", dateDecodingStrategy: .secondsSince1970){
                        (result: Result<WeatherForecast, APIService.ApiError>) in
                        switch result {
                        case .success(let forecast):
                           // self.isLoading = false
                            DispatchQueue.main.async {
                                self.forecastDay = forecast.daily.map {WeatherForecastDayliVM(forecast: $0)}
                                self.forecastHour = forecast.hourly.map {WeatherForecastHourlyVM(forecast: $0)}
                            }
                        case .failure(let apiError):
                           // self.isLoading = false
                            self.appError = AppError(errorString: apiError.localizedDescription)
                            print(apiError)
                        }
                    }
                }
            }
        }
    }
    
}

