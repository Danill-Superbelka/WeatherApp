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
    
    @Published var forecast: [WeatherForecastDayliVM] = []
    var appError: AppError? = nil
    @Published var isLoading: Bool = false
    @AppStorage("location") var storageLocation = " "
    @Published var location = ""
    
    init() {
        location = storageLocation
        getWeatherForecast()
    }
    
    func getWeatherForecast() {
        storageLocation = location
        UIApplication.shared.endEditing()
        if location == "" {
            forecast = []
        } else {
            isLoading = true
            let apiService = APIService.shared
            CLGeocoder().geocodeAddressString(location) { (placemark, error) in
                if let error = error as? CLError {
                    switch error.code{
                    case .locationUnknown, .geocodeFoundNoResult, .geocodeFoundPartialResult:
                        self.appError = AppError(errorString: NSLocalizedString("Неизвестный адрес", comment: ""))
                    case .network:
                        self.appError = AppError(errorString: NSLocalizedString("Отсутствует подключение к интернету", comment: ""))

                    default:
                        self.appError = AppError(errorString: error.localizedDescription)
                    self.isLoading = false
                    print("Ошибка:", error.localizedDescription)
                }
                if let lat = placemark?.first?.location?.coordinate.latitude,
                   let lon = placemark?.first?.location?.coordinate.longitude {
                    apiService.getJSON(stringURL: "https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(lon)&exclude=current,minutely,alerts&appid=38b4a54648c28f3f6c543eef683881cd", dateDecodingStrategy: .secondsSince1970){
                        (result: Result<WeatherForecast, APIService.ApiError>) in
                        switch result {
                        case .success(let forecast):
                            self.isLoading = false
                            DispatchQueue.main.async {
                                self.forecast = forecast.daily.map {WeatherForecastDayliVM(forecast: $0)}
                            }
                        case .failure(let apiError):
                            self.isLoading = false
                            self.appError = AppError(errorString: apiError.localizedDescription)
                            print(apiError)
                        }
                    }
                }
            }
        }
    }
    
}
}
