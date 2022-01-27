//
//  WeatherModel.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation

struct WeatherModel {
    static let empty: Self = .init(cityKorean: "", cityEnglish: "", currentTemperature: 0, currentHumidity: 0, sensibleTemperature: 0, minimumTemperature: 0, maximumTemperature: 0, atmosphericPressure: 0, windSpeed: 0, weatherDescription: "", weatherIcon: "")
    
    var cityKorean: String
    var cityEnglish: String
    var currentTemperature: Double
    var currentHumidity: Double
    var sensibleTemperature: Double
    var minimumTemperature: Double
    var maximumTemperature: Double
    var atmosphericPressure: Double
    var windSpeed: Double
    var weatherDescription: String
    var weatherIcon: String
    
    init (cityKorean: String,
          cityEnglish: String,
          currentTemperature: Double,
          currentHumidity: Double,
          sensibleTemperature: Double,
          minimumTemperature: Double,
          maximumTemperature: Double,
          atmosphericPressure: Double,
          windSpeed: Double,
          weatherDescription: String,
          weatherIcon: String) {
        
        self.cityKorean = cityKorean
        self.cityEnglish = cityEnglish
        self.currentTemperature = currentTemperature
        self.currentHumidity = currentHumidity
        self.sensibleTemperature = sensibleTemperature
        self.minimumTemperature = minimumTemperature
        self.maximumTemperature = maximumTemperature
        self.atmosphericPressure = atmosphericPressure
        self.windSpeed = windSpeed
        self.weatherDescription = weatherDescription
        self.weatherIcon = weatherIcon
   
    }
    
    
    //    init(_ cityModel: CityModel,_ weatherFromAPIEntity: WeatherFromAPIEntity) {
    //        self.cityKorean = cityModel.korean
    //        self.cityEnglish = cityModel.english
    //
    //        if let mainTemperature = weatherFromAPIEntity.mainTemperature {
    //            self.currentTemperature = mainTemperature.currentTemperature
    //            self.currentHumidity = mainTemperature.humidity
    //            self.sensibleTemperature = mainTemperature.feelsLikeTemperature
    //            self.minimumTemperature = mainTemperature.minimumTemperature
    //            self.maximumTemperature = mainTemperature.maximumTemperature
    //            self.atmosphericPressure = mainTemperature.pressure
    //        }
    //
    //        if let wind = weatherFromAPIEntity.wind {
    //            self.windSpeed = wind.windSpeed
    //        }
    //
    //        if let weather = weatherFromAPIEntity.weather {
    //            weather.forEach {
    //                self.weatherDescription = $0.description
    //                self.weatherIcon = $0.icon
    //            }
    //        }
    //
    //
    //    }
}
