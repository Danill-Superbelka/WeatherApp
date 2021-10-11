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
        ZStack{
            NavigationView {
                VStack {
                    HStack {
                        TextField("Город", text: $forecastListVM.location,
                                  onCommit: {
                            forecastListVM.getWeatherForecast()
                        })
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .overlay(
                                Button(action: {
                                    forecastListVM.location = ""
                                    forecastListVM.getWeatherForecast()
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(.gray)
                                }
                                    .padding(.horizontal),
                                alignment: .trailing
                            )
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
                                .resizable()
                                .placeholder{
                                    Image(systemName:"hourglass")
                                }
                                .scaledToFit()
                                .frame(width: 75)
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
                } //VStack
            } //NavigationView
        }//ZStack
        if forecastListVM.isLoading {
            ZStack{
                Color(.white)
                    .opacity(0.3)
                    .ignoresSafeArea()
                ProgressView("Загрузка")
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemBackground))
                    )
                    .shadow(radius: 10)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
