//
//  ContentView.swift
//  WeatherApp
//
//  Created by Даниил  on 30.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @StateObject private var forecastListVM = ForecastListVM()
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Город", text: $forecastListVM.location)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button{
                        forecastListVM.getWeatherForecast()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                }
                List(forecastListVM.forecast, id: \.day) { day in
                    Text(day.day)
                        .fontWeight(.bold)
                    HStack(alignment: .top){
                        WebImage(url: day.weatherIconUrl)
                        VStack(alignment: .leading){
                            HStack{
                            Text("\(day.high)")
                            Text("\(day.low)")
                            }
                            Text("Облачность:")
                            Text("Влажность:")
                            
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            
        }
        .padding()
        .navigationTitle("\(forecastListVM.location)")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
