//
//  WeatherForecastCoordinator.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/28.
//

import Foundation
import UIKit

class WeatherForecastCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    weak var parentsCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var selectedCity: String
    
    init(navigationController: UINavigationController, selectedCity: String) {
        self.navigationController = navigationController
        self.selectedCity = selectedCity
    }
    
    func start() {
        navigationController.delegate = self
        var diContainer = WeatherForecastDIContainer(selectedCity: selectedCity)
        let viewController = diContainer.makeWeatherForecastViewController(coordinaitor: self)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
