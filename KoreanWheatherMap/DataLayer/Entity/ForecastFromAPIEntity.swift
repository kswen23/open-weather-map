//
//  ForecastFromAPIEntity.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/30.
//

import Foundation

struct ForecastFromAPIEntity: Codable {
    let list: [list]?
    enum CodingKeys: String, CodingKey {
        case list = "list"
    }

}

struct list: Codable {
    let main: temperatureForecast?
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case main = "main"
        case time = "dt_txt"
    }
}

struct temperatureForecast: Codable {
    let maximumTemperature: Double
    let minimumTemperature: Double
    let humidity: Int
    enum CodingKeys: String, CodingKey {
        case maximumTemperature = "temp_max"
        case minimumTemperature = "temp_min"
        case humidity = "humidity"
    }
}
