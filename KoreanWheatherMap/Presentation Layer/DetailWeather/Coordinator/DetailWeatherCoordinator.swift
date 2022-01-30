//
//  DetailWeatherCoordinator.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/27.
//

import Foundation
import UIKit

class DetailWeatherCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    weak var parentsCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var selectedCity: WeatherModel
    
    init(navigationController: UINavigationController, selectedCity: WeatherModel) {
        self.navigationController = navigationController
        self.selectedCity = selectedCity
    }
    
    func start() {
        navigationController.delegate = self
        var diContainer = DetailWeatherDIContainer(selectedCity: selectedCity)
        let viewController = diContainer.makeDetailWeatherViewController(coordinaitor: self)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
        
    }
    
    func pushWeatherForecastView(city: String) {
        let child = WeatherForecastCoordinator(navigationController: navigationController, selectedCity: city)
        child.parentsCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if let weatherForecastViewController = fromViewController as? DetailWeatherViewController {
            childDidFinish(weatherForecastViewController.coordinator)
        }
    }


}

