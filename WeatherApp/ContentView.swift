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
        //   NavigationView {
        VStack {
            //                HStack{
            //                    Button(action: {
            //                        showingSheet.toggle()
            //                    }) {
            //                        Text("\(self.city)")
            //                            .font(.largeTitle)
            //                            .fontWeight(.ultraLight)
            //                            .foregroundColor(Color.black)
            //                            .multilineTextAlignment(.center)
            //                    }
            //                    .sheet(isPresented: $showingSheet){
            //                        CityList(city: self.$city, isPresented: self.$showingSheet)
            //                    }
            //                    //                    NavigationLink(destination: CityList()) {
            //                    //                        Text("City")
            //                    //                            .font(.largeTitle)
            //                    //                            .fontWeight(.ultraLight)
            //                    //                            .foregroundColor(Color.black)
            //                    //                            .multilineTextAlignment(.center)
            //                    //
            //                    //                    }
            //
            //                    //                Text("\(forecastListVM.location)")
            //                    //                    .font(.largeTitle)
            //                    //                    .fontWeight(.ultraLight)
            //                    //                    .multilineTextAlignment(.center)
            //
            //                    //                    Button{
            //                    //                        forecastListVM.getWeatherForecast()
            //                    //                    } label: {
            //                    //                        Image(systemName: "magnifyingglass.circle.fill")
            //                    //                            .font(.title3)
            //                    //                    }
            //                } // HStack
            
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
            VStack{
                HStack{
                    TextField("Город", text: $forecastListVM.location,
                              onCommit: {
                        forecastListVM.getWeatherForecast()
                    })
                    //                    .font(.system(size: 30, weight: .bold, design: .default))              .foregroundColor(Color.white)
                    //                    .frame(maxWidth: .infinity, maxHeight: 100, alignment: .center)
                    //                    .background(Color(red: 32/255, green: 36/255, blue: 38/255))
                    //                    .modifier(CardModifier())
                    //                    .padding()
                    
                }
                ScrollView(.horizontal, content: {
                    HStack(spacing: 10){
                        
                            ForEach(forecastListVM.forecastHour, id: \.day) { hour in
                                WebImage(url: hour.weatherIconUrl)
                                Text(hour.day)
                            
                        }
                    }
                    .padding(.leading, 10)
                })
                    .frame(height: 100)
                
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
                            
                            //                                Text(day.temp)
                            //                                    .font(.system(size: 26, weight: .bold, design: .default))
                            //                                    .foregroundColor(.white)
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
            
            //                    Text(day.day)
            //                        .fontWeight(.bold)
            //                    HStack(alignment: .top){
            //                        WebImage(url: day.weatherIconUrl)
            //                            .resizable()
            //                            .placeholder{
            //                                Image(systemName:"hourglass")
            //                            }
            //                            .scaledToFit()
            //                            .frame(width: 75)
            //                        VStack(alignment: .leading){
            //                            HStack{
            //                                Text("\(day.high)")
            //                                Text("\(day.low)")
            //                            }
            //                            Text("Облачность:")
            //                            Text("Влажность:")
            //                        }
            //                    }
        }
        .listStyle(PlainListStyle())
    }
    //.navigationTitle("\(forecastListVM.location)")//VStack
    //  .navigationBarHidden(true)
    // } //NavigationView
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
