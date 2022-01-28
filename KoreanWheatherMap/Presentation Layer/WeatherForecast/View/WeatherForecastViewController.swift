//
//  WeatherForecastViewController.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/28.
//

import Foundation
import UIKit

class WeatherForecastViewController: UIViewController {
    
    weak var coordinator: WeatherForecastCoordinator?
    
    var viewModel: WeatherForecastViewModel
    
    let graphScrollView = UIScrollView()
    let view2 = UIView()
    class view1: UIView {
        override func draw(_ rect: CGRect) {
            let path = UIBezierPath()
            path.lineWidth = 1
            path.lineJoinStyle = .round
            path.move(to: CGPoint(x: 20, y: 500))
            path.addLine(to: CGPoint(x: 40, y: 450))
            path.addLine(to: CGPoint(x: 60, y: 400))
            path.addLine(to: CGPoint(x: 80, y: 300))
            path.addLine(to: CGPoint(x: 100, y: 600))
            path.addLine(to: CGPoint(x: 120, y: 400))
            path.addLine(to: CGPoint(x: 140, y: 430))
            path.addLine(to: CGPoint(x: 160, y: 450))
            path.addLine(to: CGPoint(x: 180, y: 450))
            UIColor.systemRed.set()
            path.stroke()
        }
    }
    init(viewModel: WeatherForecastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        
        setupGraphScrollView()
        let view1 = view1(frame: self.view.frame)
        view1.backgroundColor = .clear
        self.view.addSubview(view1)
        setView()
        
        
    }
    
    func setupGraphScrollView() {
        view.addSubview(graphScrollView)
        graphScrollView.translatesAutoresizingMaskIntoConstraints = false
        graphScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        graphScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        graphScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        graphScrollView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        graphScrollView.backgroundColor = .white
        graphScrollView.contentSize = CGSize(width: view.frame.width * 11, height: 400)
        graphScrollView.indicatorStyle = .white
        graphScrollView.showsHorizontalScrollIndicator = true
    }
    
    func setView() {
        self.graphScrollView.addSubview(view2)
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.topAnchor.constraint(equalTo: graphScrollView.topAnchor).isActive = true
        view2.leadingAnchor.constraint(equalTo: graphScrollView.leadingAnchor).isActive = true
//        view1.trailingAnchor.constraint(equalTo: graphScrollView.trailingAnchor).isActive = true
        view2.widthAnchor.constraint(equalToConstant: self.view.frame.width*10).isActive = true
        view2.heightAnchor.constraint(equalTo: self.graphScrollView.heightAnchor).isActive = true

        view2.backgroundColor = .blue

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
