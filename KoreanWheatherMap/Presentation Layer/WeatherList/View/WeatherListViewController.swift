//
//  ViewController.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import UIKit

import RxSwift
import RxCocoa

class WeatherListViewController: UIViewController, UIScrollViewDelegate {
    
    weak var coordinator: WeatherListCoordinator?
    var viewModel: WeatherListViewModel
    let weatherListTableView = UITableView()
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
        setupWeatherListTableView()
        
        bindWeatherListTableView()
        
    }
    
    func setupBackground() {
        view.backgroundColor = .white
        self.navigationItem.title = viewModel.navigationItemTitle
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    func setupWeatherListTableView() {
        view.addSubview(weatherListTableView)
        weatherListTableView.translatesAutoresizingMaskIntoConstraints = false
        weatherListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherListTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        weatherListTableView.backgroundColor = .white
        weatherListTableView.register(WeatherListTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    func bindWeatherListTableView() {
        
        
        
        
        viewModel.weatherObserVable
            .bind(to: weatherListTableView.rx.items(cellIdentifier: "Cell", cellType: WeatherListTableViewCell.self)) {index, item, cell in
                
                cell.cityTitleLabel.text = item.cityKorean
                cell.temperatureLabel.text = "\(item.currentTemperature)"
                cell.humidityLabel.text = "\(item.currentHumidity)"
                
                do
                {
                    let url = URL(string:"http://openweathermap.org/img/wn/\(item.weatherIcon)@2x.png")
                    let data = try Data(contentsOf: url!)
                    cell.iconImageView.image = UIImage(data: data)
                }
                catch
                {
                    
                }
            }
            .disposed(by: disposeBag)
        
        weatherListTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        weatherListTableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                self?.weatherListTableView.deselectRow(at: indexPath, animated: false)
                
            })
            .disposed(by: disposeBag)
        
    }
}

