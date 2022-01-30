//
//  FetchKoreanWeatherForcastUsecase.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/30.
//

import Foundation

import RxSwift

class FetchWeatherForeCastUsecase {
    
    let disposeBag = DisposeBag()
    var maximumTemperatures: [Double] = []
    var minimumTemperatures: [Double] = []
    var humidities: [Int] = []
    var times: [String] = []
    var forecastModelObservable = PublishSubject<ForecastModel>()
    
    func fetchWeatherForecast(city: String) {
        ForecastAPIService.fetchWeatherForecastRx(city: city)
            .map { data in
                try JSONDecoder().decode(ForecastFromAPIEntity.self, from: data) }
            .subscribe(onNext: { [self] in
                $0.list?.forEach {
                    if let main = $0.main {
                        maximumTemperatures.append(main.maximumTemperature.celsius.roundDecimal(to: 2))
                        minimumTemperatures.append(main.minimumTemperature.celsius.roundDecimal(to: 2))
                        humidities.append(main.humidity)
                    }
                    let timeString = $0.time.replacingOccurrences(of: " ", with: "\n  ")
                    times.append(timeString)
                }
                self.forecastModelObservable.onNext(ForecastModel(usecase: self))
                
            })
        
            .disposed(by: disposeBag)
    }
}
