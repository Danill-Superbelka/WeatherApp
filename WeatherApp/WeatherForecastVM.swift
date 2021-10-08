//
//  WeatherForecastVM.swift
//  WeatherApp
//
//  Created by Даниил  on 08.10.2021.
//

import Foundation

struct WeatherForecastDayliVM {
    let forecast: WeatherForecast.Daily
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
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
    
    var high: String {
        return "↑ \(Self.numberFormatter.string(for: forecast.temp.max) ?? "0")°"
        
    }
    
    var low: String {
        return "↓ \(Self.numberFormatter.string(for: forecast.temp.min) ?? "0")°"
    }
    
    var feels: String {
        return "\(Self.numberFormatter.string(for: forecast.feels_like.day) ?? "0")°"
    }
}

struct WeatherForecastHourlyVM {
    let forecast: WeatherForecast.Hourly
    
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
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
        return "\(Self.numberFormatter.string(for: forecast.temp) ?? "0")°"
    }
    
    var feels: String{
        return "\(Self.numberFormatter.string(for: forecast.feels_like) ?? "0")°"
    }
}
