//
//  DetailWeatherCoordinator.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/27.
//

import Foundation
import UIKit

class DetailWeatherCoordinator: NSObject, Coordinator {

    weak var parentsCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var selectedCity: WeatherModel
    
    init(navigationController: UINavigationController, selectedCity: WeatherModel) {
        self.navigationController = navigationController
        self.selectedCity = selectedCity
    }
    
    func start() {
        var diContainer = DetailWeatherDIContainer(selectedCity: selectedCity)
        let viewController = diContainer.makeDetailWeatherViewController(coordinaitor: self)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }


}

