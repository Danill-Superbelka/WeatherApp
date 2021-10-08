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
    @State var forecast: WeatherForecast? = nil
    let dateFormatter = DateFormatter()
    
    init(){
        dateFormatter.dateFormat = "E, MMM, d"
    }
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
                if let forecast = forecast {
                    List(forecast.daily, id: \.dt) { day in
                        Text("\(dateFormatter.string(from:  day.dt))")
                            .fontWeight(.bold)
                        HStack(alignment: .top){
                            Image(systemName: "hourglass")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                            VStack(alignment: .leading){
                                Text("Погода")
                                Text("Max:")
                                Text("Min:")
                                Text("Облачность:")
                                Text("Влажность:")
                                
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Spacer()
                }
            }
            .padding(.horizontal)
            .navigationTitle("Погода")
            
        }
    }
    
    func getWeatherForecast(for location: String) {
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
                        self.forecast = forecast
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
