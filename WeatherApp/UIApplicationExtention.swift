//
//  UIApplicationExtention.swift
//  WeatherApp
//
//  Created by Даниил  on 11.10.2021.
//

import UIKit

extension  UIApplication{
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
