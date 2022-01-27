//
//  WheatherFromAPI.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation

struct WeatherFromAPIEntity: Codable {
    let mainTemperature: temperature?
    let wind: wind?
    let weather: [weather]?
    
    enum CodingKeys: String, CodingKey {
        case mainTemperature = "main"
        case wind = "wind"
        case weather = "weather"
    }
}
struct temperature: Codable {
    let currentTemperature: Double
    let feelsLikeTemperature: Double
    let minimumTemperature: Double
    let maximumTemperature: Double
    let pressure: Double
    let humidity: Double
    
    enum CodingKeys: String, CodingKey {
        case currentTemperature = "temp"
        case feelsLikeTemperature = "feels_like"
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
}
struct wind: Codable {
    let windSpeed: Double

    enum CodingKeys: String, CodingKey {
        case windSpeed = "speed"
    }
}
struct weather: Codable {
    
    let description: String
    let icon: String
    
    enum Codingkeys: String, CodingKey {
        case description = "description"
        case icon = "icon"
    }
}
