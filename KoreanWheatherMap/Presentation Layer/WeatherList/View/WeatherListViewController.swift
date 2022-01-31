//
//  ViewController.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import UIKit
import CoreLocation

import RxSwift
import RxCocoa

class WeatherListViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {
    
    weak var coordinator: WeatherListCoordinator?
    var viewModel: WeatherListViewModel
    let weatherListTableView = UITableView()
    var refreshControl = UIRefreshControl()
    var filterButton = UIButton()
    
    let locationManger = CLLocationManager()
    var myLocation: CLLocation?
    
    let disposeBag = DisposeBag()
    
    init(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupNavigationFilterButton()
        setupWeatherListTableView()
        setupRefreshControl()
        setupLocationManager()
        
        setupBindind()
        viewModel.fetchWeather()
    }
    
    func setupBindind() {
        bindWeatherListTableView()
        bindLoading()
    }
    
    func setupBackground() {
        view.backgroundColor = .white
        self.navigationItem.title = viewModel.navigationItemTitle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    func setupNavigationFilterButton() {
        filterButton.setTitle("Filter", for: .normal)
        filterButton.setTitleColor(.systemBlue, for: .normal)
        filterButton.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        let navigationBarButton = UIBarButtonItem(customView: filterButton)
        self.navigationItem.rightBarButtonItem = navigationBarButton
    }
    
    @objc func filterButtonTapped() {
        let filterViewController = FilterViewController(viewModel: self.viewModel)
        filterViewController.modalPresentationStyle = .custom
        filterViewController.transitioningDelegate = self
        self.present(filterViewController, animated: true, completion: nil)
        if let location = myLocation {
            viewModel.bindFilter(location: location)
        }
    }
    
    func setupWeatherListTableView() {
        view.addSubview(weatherListTableView)
        weatherListTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        weatherListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        weatherListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        weatherListTableView.backgroundColor = .white
        weatherListTableView.register(WeatherListTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func setupRefreshControl() {
        weatherListTableView.refreshControl = refreshControl
        weatherListTableView.refreshControl?.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    @objc func pullToRefresh() {
        viewModel.fetchWeather()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.refreshControl.endRefreshing()
        }
    }
    
    func setupLocationManager() {
        
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManger.startUpdatingLocation()
            myLocation = locationManger.location
        } else {
            print("위치 서비스 Off 상태")
        }
    }
    
    func bindWeatherListTableView() {
        viewModel.weatherViewModelObserVable
            .bind(to: weatherListTableView.rx.items(cellIdentifier: "Cell", cellType: WeatherListTableViewCell.self)) {index, item, cell in
                
                cell.cityTitleLabel.text = item.cityKorean
                cell.temperatureLabel.text = "\(item.currentTemperature.celsius.roundDecimal(to: 2))℃"
                cell.humidityLabel.text = "\(item.currentHumidity)%"
                cell.iconImageView.image = UIImage(data: item.weatherIcon)
            }
            .disposed(by: disposeBag)
        
        weatherListTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        weatherListTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.weatherListTableView.deselectRow(at: indexPath, animated: false)
                guard let selectedCity = self?.viewModel.findCity(indexPath: indexPath) else { return }
                
                self?.coordinator?.pushDetailWeatherView(city: selectedCity)
            })
            .disposed(by: disposeBag)
    }
    
    func bindLoading() {
        viewModel.loading
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] state in
                switch state {
                case .startLoading:
                    weatherListTableView.isHidden = true
                    LoadingView.showLoading()
                case .finishLoading:
                    weatherListTableView.isHidden = false
                    LoadingView.hideLoading()
                }
            })
            .disposed(by: disposeBag)
    }
    
}

extension WeatherListViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        FilterPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
