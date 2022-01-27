//
//  FetchKoreanWeather.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation

import RxSwift

class FetchKoreanWeatherUseCase {
    let cities = CityModel.cities
    
    let weatherModelsObserVable = PublishSubject<[WeatherModel]>()
    var tempWeatherModel: [WeatherModel] = []
    
    let disposeBag = DisposeBag()
    func fetchKoreanWeather() {
        cities.forEach { city in
            APIService.fetchWeatherRx(city: city.english)
                .map { data in
                    try JSONDecoder().decode(WeatherFromAPIEntity.self, from: data) }
                .subscribe(onNext: { [self] in
                    var tempWeather = WeatherModel.empty
                    
                    tempWeather.cityKorean = city.korean
                    tempWeather.cityEnglish = city.english
                    
                    if let mainTemperature = $0.mainTemperature {
                        tempWeather.currentTemperature = mainTemperature.currentTemperature
                        tempWeather.currentHumidity = mainTemperature.humidity
                        tempWeather.sensibleTemperature = mainTemperature.feelsLikeTemperature
                        tempWeather.minimumTemperature = mainTemperature.minimumTemperature
                        tempWeather.maximumTemperature = mainTemperature.maximumTemperature
                        tempWeather.atmosphericPressure = mainTemperature.pressure
                    }
                    
                    if let wind = $0.wind {
                        tempWeather.windSpeed = wind.windSpeed
                    }
                   
                    if let weather = $0.weather {
                        weather.forEach {
                            tempWeather.weatherDescription = $0.description
                            tempWeather.weatherIcon = $0.icon
                        }
                    }
                    
                    self.tempWeatherModel.append(tempWeather)
                    self.weatherModelsObserVable.onNext(self.tempWeatherModel)
                })
                .disposed(by: disposeBag)
        }
    }
    
}
