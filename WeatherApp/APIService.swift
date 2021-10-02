//
//  APIService.swift
//  WeatherApp
//
//  Created by Даниил  on 01.10.2021.
//

import Foundation

public class APIService {
    
    static let shared = APIService()
    
   public enum ApiError: Error {
        case error(_ errorString: String)
    }
   public func getJSON<T: Decodable>(stringURL: String, completion: @escaping (Result<T,ApiError>) -> Void) {
        guard let url = URL(string: stringURL) else {
            print("Ошибка получения URL адреса")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) {data, response, error in
            guard let data = data else {
                print("Ошибка получения данных")
                return
                
            }
            let decoder = JSONDecoder()
            do {
                let forecast = try decoder.decode(T.self, from: data)
                completion(.success(forecast))
            } catch let Error {
                print("Ошибка", Error)
            }
        }.resume()
    }
}
