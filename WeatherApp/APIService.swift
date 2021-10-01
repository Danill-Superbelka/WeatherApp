//
//  APIService.swift
//  WeatherApp
//
//  Created by Даниил  on 01.10.2021.
//

import Foundation

public class APIService {
    
    public let shared = APIService()
    
    public func getJSON (stringURL: String) {
        guard let url = URL(string: stringURL) else {
            print("Ошибка получения URL адреса")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else {
                print("Ошибка в получение данных")
                return
            }
            
            let decoder = JSONDecoder()
            guard let forecast = try? decoder.decode(WeatherForecast.self, from: data) else {
                print("Ошибка декодирования данных")
                return
            }
        }.resume()
    }
}
