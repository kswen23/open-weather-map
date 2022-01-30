//
//  WeatherListDIContainer.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation
import UIKit

class WeatherListDIContainer {
    func makeWeatherListViewController(coordinaitor: Coordinator) -> WeatherListViewController {
        
        return WeatherListViewController(viewModel: makeWeatherListViewModel())
    }
    
    func makeWeatherListViewModel() -> WeatherListViewModel {
        let fetchWeatherUseCase = FetchWeatherUseCase()
        return WeatherListViewModel(fetchKoreanWeatherUseCase: fetchWeatherUseCase)
    }
    
}
