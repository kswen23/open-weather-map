//
//  MainCoordinator.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation
import UIKit

class WeatherListCoordinator: NSObject, Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var diContainer = WeatherListDIContainer()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = diContainer.makeWeatherListViewController(coordinaitor: self)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func pushDetailWeatherView(city: WeatherModel) {
        let child = DetailWeatherCoordinator(navigationController: navigationController, selectedCity: city)
        child.parentsCoordinator = self
        childCoordinators.append(child)
        child.start()
    }



}
