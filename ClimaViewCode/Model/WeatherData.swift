//
//  WeatherData.swift
//  ClimaViewCode
//
//  Created by Jean Lucas Vitor on 02/05/22.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    
}

struct Main: Codable {
    let temp: Double
    
}

struct Weather: Codable {
    let id: Int
    let description: String
    
}
