//
//  WeatherListViewModel.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation

import RxSwift
import CoreLocation

enum LoadingState {
    case startLoading
    case finishLoading
}
enum FilterState {
    case closest
    case highestTemperature
    case lowestTemperature
    case biggestName
    case smallestName
}

class WeatherListViewModel {
    var fetchKoreanWeatherUseCase: FetchWeatherUseCase
    var filterUseCase: FilterUseCase
    
    init(fetchKoreanWeatherUseCase: FetchWeatherUseCase, filterUseCase: FilterUseCase) {
        self.fetchKoreanWeatherUseCase = fetchKoreanWeatherUseCase
        self.filterUseCase = filterUseCase
        bindFetchWeatherUsecaseModels()
    }
    
    let navigationItemTitle = "How's the weather?"
    
    let weatherViewModelObserVable = BehaviorSubject<[WeatherModel]>(value: [])
    let loading = PublishSubject<LoadingState>()
    var weatherModels = [WeatherModel]()
    
    var tableViewItems = ["거리가까운 순서", "현재 기온순🔼", "현재 기온순🔽", "도시 이름순🔼", "도시 이름순🔽"]
    let filterObservable = PublishSubject<FilterState>()
    
    let disposeBag = DisposeBag()
    
    func fetchWeather() {
        loading.onNext(.startLoading)
        fetchKoreanWeatherUseCase.fetchKoreanWeather()
    }
    
    func bindFetchWeatherUsecaseModels() {
        fetchKoreanWeatherUseCase.weatherModelsObserVable
            .subscribe(onNext: { [self]  in
                weatherModels = $0
                weatherViewModelObserVable.onNext($0)
                loading.onNext(.finishLoading)
            })
            .disposed(by: disposeBag)
    }
    
    func findCity(indexPath: IndexPath) -> WeatherModel {
        var selectedCity = WeatherModel.empty
        
        weatherViewModelObserVable
            .filter({ !$0.isEmpty })
            .subscribe(onNext: { city in
                selectedCity = city[indexPath.row]
            })
            .disposed(by: disposeBag)
        
        return selectedCity
    }
    
    func bindFilter(location: CLLocation) {
        filterObservable
            .subscribe(onNext: { [self] state in
                filterUseCase.filter(by: state, models: self.weatherModels, location: location)
            })
            .disposed(by: disposeBag)
        
        filterUseCase.weatherModelsObserVable
            .subscribe(onNext: { [self] in
                weatherViewModelObserVable.onNext($0)
            })
            .disposed(by: disposeBag)
    }
}
