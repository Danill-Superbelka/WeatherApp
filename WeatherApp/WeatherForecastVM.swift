//
//  WeatherForecastVM.swift
//  WeatherApp
//
//  Created by Даниил  on 08.10.2021.
//

import Foundation
import SwiftUI

func convert(_ temp: Double) -> Double {
    let celsius = temp - 273.5
    return celsius
}

struct WeatherForecastDayliVM {
    let forecast: WeatherForecast.Daily
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, d"
        return dateFormatter
    }
    
    private static var numberFormatter: NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatterPercent: NumberFormatter{
        let numberFormatterPercent = NumberFormatter()
        numberFormatterPercent.numberStyle = .percent
        return numberFormatterPercent
    }
    
    
    var day: String {
        return Self.dateFormatter.string(from: forecast.dt)
    }
    
//    var temp: String {
//        return "\(Self.numberFormatter.string(for: convert(forecast.temp.day)) ?? "0")°"
//    }
    
    var high: String {
        return "↑ \(Self.numberFormatter.string(for: convert(forecast.temp.max)) ?? "0")°"
        
    }
    
    var low: String {
        return "↓ \(Self.numberFormatter.string(for: convert(forecast.temp.min)) ?? "0")°"
    }
    
    var feels: String {
        return "\(Self.numberFormatter.string(for: convert(forecast.feels_like.day)) ?? "0")°"
    }
    
    var weatherIconUrl: URL {
        let imageURL = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: imageURL)!
        }

}

struct WeatherForecastHourlyVM {
    let forecast: WeatherForecast.Hourly
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH, d"
        return dateFormatter
    }
    
    private static var numberFormatter: NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    private static var numberFormatterPercent: NumberFormatter{
        let numberFormatterPercent = NumberFormatter()
        numberFormatterPercent.numberStyle = .percent
        return numberFormatterPercent
    }
    
    var day: String {
        return Self.dateFormatter.string(from: forecast.dt)
    }
    
    var temp: String{
        return "\(Self.numberFormatter.string(for: convert(forecast.temp)) ?? "0")°"
    }
    
    var feels: String{
        return "\(Self.numberFormatter.string(for: convert(forecast.feels_like)) ?? "0")°"
    }
    
    var weatherIconUrl: URL {
    let imageURL = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: imageURL)!
        }

}

