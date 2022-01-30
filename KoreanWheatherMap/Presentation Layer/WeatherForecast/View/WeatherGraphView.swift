//
//  WhetherGraphView.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/30.
//

import Foundation
import UIKit

class WeatherGraphView: UIView {
    var maximumTemperatureValues: [Double] = []
    var minimumTemperatureValues: [Double] = []
    var humidityValues: [Int] = []
    var timeValues: [String] = []
    
    var currentX: CGFloat = 30

    init(frame: CGRect,
         maximumTemperatureValues: [Double],
         minimumTemperatureValues: [Double],
         humidityValues: [Int],
         timeValues: [String]) {
        super.init(frame: frame)
        self.maximumTemperatureValues = maximumTemperatureValues
        self.minimumTemperatureValues = minimumTemperatureValues
        self.humidityValues = humidityValues
        self.timeValues = timeValues
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        makeTemperatureGraph(value: minimumTemperatureValues, vertical: 0.9, lineColor: .blue)
        makeTemperatureGraph(value: maximumTemperatureValues, vertical: 0.7, lineColor: .red)
        makeHumidityGraph(value: humidityValues, lineColor: .black)
    }
    func makeTemperatureGraph(value: [Double], vertical: Double, lineColor: UIColor) {
        let graph = UIBezierPath()
        let xOffset: CGFloat = (self.frame.width - 2*currentX) / CGFloat(value.count-1)
        let start = CGPoint(x: currentX, y: (self.frame.height * vertical) - value[0]*4)
        graph.move(to: start)
        makeTemperatureLabel(value: value[0], point: start)
        
        for i in 1..<value.count {
            currentX += xOffset
            let addingPoint = CGPoint(x: currentX, y:  (self.frame.height * vertical) - value[i]*4)
            graph.addLine(to: addingPoint)
            makeTemperatureLabel(value: value[i], point: addingPoint)
        }
        lineColor.set()
        graph.lineWidth = 3
        graph.lineJoinStyle = .round
        graph.stroke()
    }
    
    func makeHumidityGraph(value: [Int], lineColor: UIColor) {
        let graph = UIBezierPath()
        let xOffset: CGFloat = (self.frame.width - 2*currentX) / CGFloat(value.count-1)
        let halfHeight: CGFloat = (self.frame.height / 2)
        let start = CGPoint(x: currentX, y: halfHeight - CGFloat(value[0]))
        graph.move(to: start)
        makeHumidityLabel(value: CGFloat(value[0]), point: start)
        makeTimeLabel(value: timeValues[0], point: start)
        
        for i in 1..<value.count {
            currentX += xOffset
            let addingPoint = CGPoint(x: currentX, y: halfHeight - CGFloat(value[i]))
            graph.addLine(to: addingPoint)
            makeHumidityLabel(value: CGFloat(value[i]), point: addingPoint)
            makeTimeLabel(value: timeValues[i], point: addingPoint)
        }
        lineColor.set()
        graph.lineWidth = 3
        graph.lineJoinStyle = .round
        graph.stroke()
    }
    
    func makeTemperatureLabel(value: CGFloat, point: CGPoint) {
        let label = UILabel()
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: self.topAnchor, constant: point.y - 5).isActive = true
        label.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: point.x).isActive = true
        label.textColor = .black
        label.text = "\(value)℃"
    }
    
    func makeHumidityLabel(value: CGFloat, point: CGPoint) {
        let label = UILabel()
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: self.topAnchor, constant: point.y - 5).isActive = true
        label.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: point.x).isActive = true
        label.textColor = .black
        label.text = "\(Int(value))%"
    }
    
    func makeTimeLabel(value: String, point: CGPoint) {
        let label = UILabel()
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: point.x).isActive = true
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 10, weight: .light)
        label.numberOfLines = 0
        label.text = value

    }
}
