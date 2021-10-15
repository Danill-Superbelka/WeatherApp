//
//  ContentView.swift
//  WeatherApp
//
//  Created by Даниил  on 30.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @ObservedObject private var forecastListVM = ForecastListVM()
    @State var showingSheet: Bool = false
    @AppStorage("city") var city: String = " "
    var body: some View {
        VStack {
           
            VStack{
                Section{
                    HStack{
                        TextField("City", text: $forecastListVM.location,
                                  onCommit: {
                            forecastListVM.getWeatherForecast()
                        })
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding(.leading, 10)
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .padding(.all, 10)
                    }
                    .foregroundColor(Color.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(red: 32/255, green: 36/255, blue: 38/255))
                    .modifier(CardModifier())
                    .padding(.all, 10)
                }
                Section{
                    ScrollView(.horizontal, content: {
                        HStack(spacing: 10){
                            
                            ForEach(forecastListVM.forecastHour, id: \.day) { hour in
                                VStack{
                                    WebImage(url: hour.weatherIconUrl)
                                    Text(hour.temp)
                                        .foregroundColor(Color.white)
                                    Text(hour.hour)
                                        .foregroundColor(Color.white)
                                    Text(hour.day)
                                        .foregroundColor(Color.white)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.leading, 10)
                    })
                        .frame(height: 115)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
                        .modifier(CardModifier())
                        .padding(.all, 10)
                }
                
            }
            
            
            
            List(forecastListVM.forecastDay, id: \.day) { day in
                HStack(alignment: .center){
                    WebImage(url: day.weatherIconUrl)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .padding(.all, 20)
                    VStack(alignment: .leading){
                        HStack{
                            Text(day.day)
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .foregroundColor(.white)
                        }
                        HStack{
                            Text(day.high)
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .foregroundColor(.gray)
                            Text(day.low)
                                .font(.system(size: 16, weight: .bold, design: .default))
                                .foregroundColor(.gray)
                        }
                        
                    }.padding(.trailing, 20)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color(red: 32/255, green: 36/255, blue: 38/255))
                .modifier(CardModifier())
                .padding(.all, 10)
                
            }
        }
        .listStyle(PlainListStyle())
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
