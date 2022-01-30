//
//  ForecastModel.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/30.
//

import Foundation

struct ForecastModel {
    var maximumTemperatures: [Double]
    var minimumTemperatures: [Double]
    var humidities: [Int]
    var times: [String]
    
    init(usecase: FetchWeatherForeCastUsecase) {
        self.minimumTemperatures = usecase.minimumTemperatures
        self.maximumTemperatures = usecase.maximumTemperatures
        self.humidities = usecase.humidities
        self.times = usecase.times
    }
}
