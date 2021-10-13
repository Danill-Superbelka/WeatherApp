//
//  CityList.swift
//  WeatherApp
//
//  Created by Даниил  on 13.10.2021.
//

import SwiftUI


struct CityList: View {
    @ObservedObject private var forecastListVM = ForecastListVM()
    @State var cityList: [String] = ["Moscow", "Vancouver"]
    @Binding var city: String
    @Binding var isPresented: Bool
    @State var cityName = " "
    
    func getWeather(location: String){
        forecastListVM.location = location
        forecastListVM.getWeatherForecast()
        self.city = location
        self.isPresented = false
    }
    
    private func deleteRow(at indexSet: IndexSet){
        self.cityList.remove(atOffsets: indexSet)
    }
    
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center) {
                HStack(alignment: .top) {
                    TextField("Город", text: $cityName, onCommit: {
                    })
                    Button("Add"){
                        cityList.append(cityName)
                    }
                    //                    TextField("Город", text: $forecastListVM.location,
                    //                              onCommit: {
                    //                        forecastListVM.getWeatherForecast()
                    //                    })
                    //                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                List{
                    ForEach(cityList, id: \.self){ cityName in
                        Button("\(cityName)"){
                            print("Начало функции getWeather для \(cityName)")
                            getWeather(location: cityName)
                        }
                        
                    }.onDelete(perform: self.deleteRow)
                }
                
            }
        }
    }
}


struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        CityList(city: .constant(""), isPresented: .constant(false))
    }
}

