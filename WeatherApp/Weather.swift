//
//  Weather.swift
//  WeatherApp
//
//  Created by Даниил  on 01.10.2021.
//

import Foundation

struct Weather: Codable {
    let id: Int
    let icon: String
    var weatherIconUrl: URL {
    let imageURL = "http://openweathermap.org/img/wn/\(icon)@2x.png"
        return URL(string: imageURL)!
        }
}

struct WeatherForecast: Codable {
    
    struct Hourly: Codable {
        
        let dt: Date
        let temp: Double
        let feels_like:Double
        let humidity: Int
        let clouds: Int
        let wind_speed: Double
        let weather: [Weather]
    }
    
    struct Daily: Codable {
        
        struct Temp: Codable {
            let max: Double
            let min: Double
        }
        struct FeelsLike: Codable {
            let day: Double
        }
        
        let dt: Date
        let temp: Temp
        let feels_like: FeelsLike
        let humidity: Int
        let weather: [Weather]
    }
    
    let hourly: Hourly
    let daily: [Daily]
}

let weather = APIService.shared

weather.getJSON(stringURL: "https://api.openweathermap.org/data/2.5/onecall?lat=59.934256&lon=30.335123&exclude=current,minutely,hourly,alerts&appid=38b4a54648c28f3f6c543eef683881cd") { result: Result<WeatherForecast,APIService.APIError> in
    <#code#>
}
