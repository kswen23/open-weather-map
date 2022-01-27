//
//  WeatherListViewModel.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation

import RxSwift

enum LoadingState {
    case startLoading
    case finishLoading
}
class WeatherListViewModel {
    var fetchKoreanWeatherUseCase: FetchKoreanWeatherUseCase
    
    init(fetchKoreanWeatherUseCase: FetchKoreanWeatherUseCase) {
        self.fetchKoreanWeatherUseCase = fetchKoreanWeatherUseCase
        bindWeatherModels()
    }
    
    let navigationItemTitle = "How's the weather?"
    
    let weatherObserVable = BehaviorSubject<[WeatherModel]>(value: [])
    let loading = PublishSubject<LoadingState>()
    
    let disposeBag = DisposeBag()
    
    func fetchWeather() {
        loading.onNext(.startLoading)
        fetchKoreanWeatherUseCase.fetchKoreanWeather()
    }
    
    func bindWeatherModels() {
        fetchKoreanWeatherUseCase.weatherModelsObserVable
            .subscribe(onNext: { [self]  in
                weatherObserVable.onNext($0)
                loading.onNext(.finishLoading)
            })
            .disposed(by: disposeBag)
    }
    
    func findCity(indexPath: IndexPath) -> WeatherModel {
        var selectedCity = WeatherModel.empty
        
        weatherObserVable
            .filter({ !$0.isEmpty })
            .subscribe(onNext: { city in
                selectedCity = city[indexPath.row]
            })
            .disposed(by: disposeBag)
        
        return selectedCity
    }
    
}
