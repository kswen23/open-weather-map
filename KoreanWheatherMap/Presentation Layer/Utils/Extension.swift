//
//  Extension.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/28.
//

import Foundation
import UIKit

extension Double {
    var celsius: Double { return self - 273.15}
    func roundDecimal(to place: Int) -> Double {
        let modifiedNumber = pow(10, Double(place))
        var n = self
        n = n * modifiedNumber
        n.round()
        n = n / modifiedNumber
        return n
    }
}
extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
