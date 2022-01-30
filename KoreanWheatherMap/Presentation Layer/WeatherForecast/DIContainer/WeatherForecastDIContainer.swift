//
//  WeatherForecastDIContainer.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/28.
//

import Foundation
import UIKit

class WeatherForecastDIContainer {
    var selectedCity: String
    
    init(selectedCity: String) {
        self.selectedCity = selectedCity
    }
    
    func makeWeatherForecastViewController(coordinaitor: Coordinator) -> WeatherForecastViewController {
        return WeatherForecastViewController(viewModel: makeWeatherForecastViewModel())
    }
    
    func makeWeatherForecastViewModel() -> WeatherForecastViewModel {
        let fetchForecastUsecase = FetchWeatherForeCastUsecase()
        return WeatherForecastViewModel(selectedCity: selectedCity, fetchForecastUsecase: fetchForecastUsecase)
    }
    
}

