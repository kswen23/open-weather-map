//
//  Coordinator.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
