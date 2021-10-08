//
//  ContentView.swift
//  WeatherApp
//
//  Created by Даниил  on 30.09.2021.
//

import SwiftUI

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
            }             }
        .padding(.horizontal)
        .navigationTitle("Погода")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
