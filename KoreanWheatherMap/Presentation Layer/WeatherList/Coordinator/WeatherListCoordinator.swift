//
//  MainCoordinator.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation
import UIKit

class WeatherListCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var diContainer = WeatherListDIContainer()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
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

        if let detailWeatherViewController = fromViewController as? DetailWeatherViewController {
            childDidFinish(detailWeatherViewController.coordinator)
        }
    }




}
