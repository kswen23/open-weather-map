//
//  FetchKoreanWeather.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation

import RxSwift

class FetchWeatherUseCase {
    let cities = CityModel.cities
    
    let weatherModelsObserVable = PublishSubject<[WeatherModel]>()
    var tempWeatherModel: [WeatherModel] = []
    
    let disposeBag = DisposeBag()
    func fetchKoreanWeather() {
        tempWeatherModel.removeAll()
        cities.forEach { city in
            WeatherAPIService.fetchWeatherRx(city: city.english)
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
                            do {
                                let url = URL(string:"http://openweathermap.org/img/wn/\($0.icon)@2x.png")
                                let data = try Data(contentsOf: url!)
                                tempWeather.weatherIcon = data
                            } catch { return }
                        }
                    }
                    self.tempWeatherModel.append(tempWeather)
                    self.weatherModelsObserVable.onNext(self.tempWeatherModel)
                })
                .disposed(by: disposeBag)
        }
    }
}
