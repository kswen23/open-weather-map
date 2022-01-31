//
//  FilterUseCase.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/31.
//

import Foundation

import RxSwift
import CoreLocation

struct CityResults {
    var name: String
    var result: Double
    
    init(name: String, result: Double){
        self.name = name
        self.result = result
    }
}
class FilterUseCase {
    let cities = CityModel.cities
    var cityResults: [CityResults] = []
    let weatherModelsObserVable = PublishSubject<[WeatherModel]>()
    var closestWeatherModel: [WeatherModel] = []
    let disposeBag = DisposeBag()
    
    func filter(by state: FilterState, models: [WeatherModel], location: CLLocation) {
        var newModels = [WeatherModel]()
        switch state {
        case .closest:
            let closestCities = filterCloseCity(latitude: location.coordinate.latitude,
                                                longtitude: location.coordinate.longitude)
            for i in 0...closestCities.count-1 {
                models.forEach{ city in
                    if closestCities[i].name.caseInsensitiveCompare(city.cityKorean) == .orderedSame {
                        closestWeatherModel.append(city)
                    }
                }
            }
            weatherModelsObserVable.onNext(closestWeatherModel)
        case .highestTemperature:
            newModels = models.sorted(by: {$0.currentTemperature > $1.currentTemperature})
            weatherModelsObserVable.onNext(newModels)
        case .lowestTemperature:
            newModels = models.sorted(by: {$0.currentTemperature < $1.currentTemperature})
            weatherModelsObserVable.onNext(newModels)
        case .biggestName:
            newModels = models.sorted(by: {$0.cityKorean < $1.cityKorean})
            weatherModelsObserVable.onNext(newModels)
        case .smallestName:
            newModels = models.sorted(by: {$0.cityKorean > $1.cityKorean})
            weatherModelsObserVable.onNext(newModels)
        }
        
    }
    
    func filterCloseCity(latitude: Double, longtitude: Double) -> [CityResults] {
        
        cities.forEach { city in
            let subLatitude = latitude - city.latitude
            let subLongtitude = longtitude - city.longtitude
            let result = subLatitude*subLatitude + subLongtitude*subLongtitude
            cityResults.append(CityResults.init(name: city.korean, result: result))
        }
        return cityResults.sorted(by: {$0.result < $1.result})
    }
}
