//
//  WeatherForecastAPIService.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/30.
//

import Foundation

import RxSwift

class ForecastAPIService {
    var dataStructure: WeatherFromAPIEntity?
    
    static func fetchWeatherForecast(city: String, onComplete: @escaping (Result<Data, Error>) -> Void) {
        let baseURL = "http://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=a635d626aae034351dffae5577e9795d"
        
        URLSession.shared.dataTask(with: URL(string: baseURL)!) { data, response, error in
            if let error = error {
                onComplete(.failure(error))
                return
            }
            guard let data = data else {
                let httpResponse = response as! HTTPURLResponse
                onComplete(.failure(NSError(domain: "no data",
                                            code: httpResponse.statusCode,
                                            userInfo: nil)))
                return
            }
            onComplete(.success(data))
        }.resume()
    }
    
    static func fetchWeatherForecastRx(city: String) -> Observable<Data> {
        return Observable.create() { emitter in
            fetchWeatherForecast(city: city) { result in
                switch result {
                case let .success(data):
                    emitter.onNext(data)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
