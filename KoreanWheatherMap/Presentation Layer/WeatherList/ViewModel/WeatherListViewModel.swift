//
//  WeatherListViewModel.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation

import RxSwift

class WeatherListViewModel {
    var fetchKoreanWeatherUseCase: FetchKoreanWeatherUseCase
    
    init(fetchKoreanWeatherUseCase: FetchKoreanWeatherUseCase) {
        self.fetchKoreanWeatherUseCase = fetchKoreanWeatherUseCase
        fetchKoreanWeatherUseCase.fetchKoreanWeather()
        bindWeatherModels()
    }
    
    let navigationItemTitle = "How's the weather?"
    
    let weatherObserVable = BehaviorSubject<[WeatherModel]>(value: [])
    
    let disposeBag = DisposeBag()
    
    func bindWeatherModels() {
        fetchKoreanWeatherUseCase.weatherModelsObserVable
            .subscribe(onNext: { [self]  in
                weatherObserVable.onNext($0)
            })
            .disposed(by: disposeBag)
    }
    
}
