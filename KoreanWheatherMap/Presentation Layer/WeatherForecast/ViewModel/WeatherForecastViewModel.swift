//
//  WeatherForecastViewModel.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/28.
//

import Foundation

import RxSwift

class WeatherForecastViewModel {
    let selectedCity: String
    let fetchForecastUsecase: FetchWeatherForeCastUsecase
    
    let disposeBag = DisposeBag()
    
    var forecastModelObservable = PublishSubject<ForecastModel>()
    var forecastViewModel = ForecastModel(maximumTemperatures: [], minimumTemperatures: [], humidities: [], times: [])
    let loading = PublishSubject<LoadingState>()
    
    init(selectedCity: String, fetchForecastUsecase: FetchWeatherForeCastUsecase) {
        self.selectedCity = selectedCity
        self.fetchForecastUsecase = fetchForecastUsecase
        bindForecastModelObservable()
    }
    
    func fetch() {
        loading.onNext(.startLoading)
        fetchForecastUsecase.fetchWeatherForecast(city: selectedCity)
    }
    
    func bindForecastModelObservable() {
        fetchForecastUsecase.forecastModelObservable
            .subscribe(onNext: { [self]  in
                forecastViewModel.self = $0
                forecastModelObservable.onNext(forecastViewModel)
                loading.onNext(.finishLoading)
            })
            .disposed(by: disposeBag)
    }
    
    func showGraphView() {
        forecastModelObservable.onNext(forecastViewModel)
    }
    
}
