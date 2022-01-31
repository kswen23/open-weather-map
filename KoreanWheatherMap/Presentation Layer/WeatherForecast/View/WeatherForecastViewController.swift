//
//  WeatherForecastViewController.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/28.
//

import Foundation
import UIKit

import RxSwift

class WeatherForecastViewController: UIViewController {
    
    weak var coordinator: WeatherForecastCoordinator?
    
    var viewModel: WeatherForecastViewModel
    
    let scrollView = UIScrollView()
    
    var heightConstraint = NSLayoutConstraint()
    var horizontalHeightConstraint = NSLayoutConstraint()
    
    let disposeBag = DisposeBag()
    
    init(viewModel: WeatherForecastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupScrollView()
        
        setupBindind()
        viewModel.fetch()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            heightConstraint.isActive = false
            horizontalHeightConstraint.isActive = true
        } else {
            horizontalHeightConstraint.isActive = false
            heightConstraint.isActive = true
        }
        viewModel.showGraphView()
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        heightConstraint = scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7)
        heightConstraint.isActive = true
        
        horizontalHeightConstraint = scrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        
        scrollView.backgroundColor = .white
        scrollView.contentSize = CGSize(width: view.frame.width * 7, height: scrollView.frame.height)
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func setupBindind() {
        bindGraphView()
        bindLoading()
    }
    
    func bindGraphView() {
        viewModel.forecastModelObservable
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [self]  in
                let weatherGraphView = WeatherGraphView(frame: CGRect(), maximumTemperatureValues: $0.maximumTemperatures, minimumTemperatureValues: $0.minimumTemperatures, humidityValues: $0.humidities, timeValues: $0.times)
                self.scrollView.addSubview(weatherGraphView)
                weatherGraphView.translatesAutoresizingMaskIntoConstraints = false
                weatherGraphView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
                weatherGraphView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
                weatherGraphView.widthAnchor.constraint(equalToConstant: scrollView.contentSize.width).isActive = true
                weatherGraphView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor).isActive = true
                weatherGraphView.backgroundColor = .white
            })
            .disposed(by: disposeBag)
    }
    
    func bindLoading() {
        viewModel.loading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] state in
                switch state {
                case .startLoading:
                    LoadingView.showLoading()
                case .finishLoading:
                    LoadingView.hideLoading()
                }
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
