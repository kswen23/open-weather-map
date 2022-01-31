//
//  DetailWeatherDIContainer.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/27.
//

import Foundation
import UIKit

class DetailWeatherDIContainer {
    var selectedCity: WeatherModel
    
    init(selectedCity: WeatherModel) {
        self.selectedCity = selectedCity
    }
    
    func makeDetailWeatherViewController(coordinaitor: Coordinator) -> DetailWeatherViewController {
        return DetailWeatherViewController(viewModel: makeDetailWeatherViewModel())
    }
    
    func makeDetailWeatherViewModel() -> DetailWeatherViewModel {
        return DetailWeatherViewModel(detailWeather: selectedCity)
    }
    
}
