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
        NavigationView {
            VStack {
                HStack{
                    Button(action: {
                        showingSheet.toggle()
                    }) {
                        Text("\(self.city)")
                            .font(.largeTitle)
                            .fontWeight(.ultraLight)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                    }
                    .sheet(isPresented: $showingSheet){
                        CityList(city: self.$city, isPresented: self.$showingSheet)
                    }
//                    NavigationLink(destination: CityList()) {
//                        Text("City")
//                            .font(.largeTitle)
//                            .fontWeight(.ultraLight)
//                            .foregroundColor(Color.black)
//                            .multilineTextAlignment(.center)
//
//                    }
                    
                    //                Text("\(forecastListVM.location)")
                    //                    .font(.largeTitle)
                    //                    .fontWeight(.ultraLight)
                    //                    .multilineTextAlignment(.center)
                    
//                    Button{
//                        forecastListVM.getWeatherForecast()
//                    } label: {
//                        Image(systemName: "magnifyingglass.circle.fill")
//                            .font(.title3)
//                    }
                }
                
//                HStack {
//                    TextField("Город", text: $forecastListVM.location,
//                              onCommit: {
//                        forecastListVM.getWeatherForecast()
//                    })
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//
//                    //                Button{
//                    //                    forecastListVM.getWeatherForecast()
//                    //                } label: {
//                    //                    Image(systemName: "magnifyingglass.circle.fill")
//                    //                        .font(.title3)
//                    //                }
//                }
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
            }
            //.navigationTitle("\(forecastListVM.location)")//VStack
            .navigationBarHidden(true)
        } //NavigationView
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
