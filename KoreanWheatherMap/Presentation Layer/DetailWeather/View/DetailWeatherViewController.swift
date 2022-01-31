//
//  DetailWeatherViewController.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/27.
//

import Foundation
import UIKit

class DetailWeatherViewController: UIViewController {
    
    weak var coordinator: DetailWeatherCoordinator?
    
    var viewModel: DetailWeatherViewModel
    
    var widthConstraint = NSLayoutConstraint()
    var horizontalWidthConstraint = NSLayoutConstraint()
    
    init(viewModel: DetailWeatherViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    let weatherIconImageView = UIImageView()
    let descriptionLabel = UILabel()
    let currentTemperatureLabel = UILabel()
    let sensibleTemperatureLabel = UILabel()
    let maximumTemperatureLabel = UILabel()
    let minimumTemperatureLabel = UILabel()
    let currentHumidityLabel = UILabel()
    let windSpeedLabel = UILabel()
    let atmosphericPressureLabel = UILabel()
    let weatherForecastButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            widthConstraint.isActive = false
            horizontalWidthConstraint.isActive = true
        }
    }
    
    func setupViews() {
        setupBackground()
        setupWeatherIconImageView()
        setupDescriptionLabel()
        setupCurrentTemperatureLabel()
        setupSensibleTemperatureLabel()
        setupMaximumTemperatureLabel()
        setupMinimumTemperatureLabel()
        setupCurrentHumidityLabel()
        setupWindSpeedLabel()
        setupAtmosphericPressureLabel()
        setupWeatherForecastButton()
    }
    
    func setupBackground() {
        view.backgroundColor = .white
        self.navigationItem.title = "\(viewModel.detailWeather.cityKorean) (\(viewModel.detailWeather.cityEnglish))"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    func setupWeatherIconImageView() {
        view.addSubview(weatherIconImageView)
        weatherIconImageView.translatesAutoresizingMaskIntoConstraints = false
        weatherIconImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        weatherIconImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weatherIconImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        weatherIconImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        weatherIconImageView.contentMode = .scaleAspectFit
        weatherIconImageView.image = UIImage(data: viewModel.detailWeather.weatherIcon)
    }
    func setupDescriptionLabel() {
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: weatherIconImageView.bottomAnchor).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        descriptionLabel.text = "오늘의 날씨는 \(viewModel.detailWeather.weatherDescription) 입니다"
        descriptionLabel.textColor = .black
        descriptionLabel.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
    }
    func setupCurrentTemperatureLabel() {
        view.addSubview(currentTemperatureLabel)
        currentTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        currentTemperatureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50).isActive = true
        currentTemperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        currentTemperatureLabel.text = "현재 기온: \(viewModel.detailWeather.currentTemperature.celsius.roundDecimal(to: 2))℃"
        currentTemperatureLabel.textColor = .black
    }
    func setupSensibleTemperatureLabel() {
        view.addSubview(sensibleTemperatureLabel)
        sensibleTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        sensibleTemperatureLabel.topAnchor.constraint(equalTo: currentTemperatureLabel.bottomAnchor, constant: 10).isActive = true
        sensibleTemperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        sensibleTemperatureLabel.text = "체감 기온: \(viewModel.detailWeather.sensibleTemperature.celsius.roundDecimal(to: 2))℃"
        sensibleTemperatureLabel.textColor = .black
    }
    func setupMaximumTemperatureLabel() {
        view.addSubview(maximumTemperatureLabel)
        maximumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        maximumTemperatureLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 50).isActive = true
        maximumTemperatureLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        maximumTemperatureLabel.text = "최고 기온: \(viewModel.detailWeather.maximumTemperature.celsius.roundDecimal(to: 2))℃"
        maximumTemperatureLabel.textColor = .red
    }
    func setupMinimumTemperatureLabel() {
        view.addSubview(minimumTemperatureLabel)
        minimumTemperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        minimumTemperatureLabel.topAnchor.constraint(equalTo: maximumTemperatureLabel.bottomAnchor, constant: 10).isActive = true
        minimumTemperatureLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        minimumTemperatureLabel.text = "최저 기온: \(viewModel.detailWeather.minimumTemperature.celsius.roundDecimal(to: 2))℃"
        minimumTemperatureLabel.textColor = .blue
    }
    func setupCurrentHumidityLabel() {
        view.addSubview(currentHumidityLabel)
        currentHumidityLabel.translatesAutoresizingMaskIntoConstraints = false
        currentHumidityLabel.topAnchor.constraint(equalTo: sensibleTemperatureLabel.bottomAnchor, constant: 10).isActive = true
        currentHumidityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        currentHumidityLabel.text = "현재 습도: \(viewModel.detailWeather.currentHumidity)%"
        currentHumidityLabel.textColor = .black
    }
    func setupWindSpeedLabel() {
        view.addSubview(windSpeedLabel)
        windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
        windSpeedLabel.topAnchor.constraint(equalTo: currentHumidityLabel.bottomAnchor, constant: 10).isActive = true
        windSpeedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        windSpeedLabel.text = "풍속: \(viewModel.detailWeather.windSpeed)m/s"
        windSpeedLabel.textColor = .black
    }
    func setupAtmosphericPressureLabel() {
        view.addSubview(atmosphericPressureLabel)
        atmosphericPressureLabel.translatesAutoresizingMaskIntoConstraints = false
        atmosphericPressureLabel.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 10).isActive = true
        atmosphericPressureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        atmosphericPressureLabel.text = "기압: \(viewModel.detailWeather.atmosphericPressure)Pa"
        atmosphericPressureLabel.textColor = .black
    }
    
    func setupWeatherForecastButton() {
        view.addSubview(weatherForecastButton)
        weatherForecastButton.translatesAutoresizingMaskIntoConstraints = false
        weatherForecastButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        widthConstraint = weatherForecastButton.widthAnchor.constraint(equalToConstant: view.frame.width - 20)
        widthConstraint.isActive = true
        
        horizontalWidthConstraint = weatherForecastButton.widthAnchor.constraint(equalToConstant: (view.frame.width) - 20)
        
        weatherForecastButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        weatherForecastButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        weatherForecastButton.backgroundColor = .black
        weatherForecastButton.setTitle("미래날씨", for: .normal)
        weatherForecastButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        weatherForecastButton.roundCorners(cornerRadius: 15, maskedCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner])
        weatherForecastButton.addTarget(self, action: #selector(weatherForeCast), for: .touchUpInside)
    }
    @objc func weatherForeCast() {
        coordinator?.pushWeatherForecastView(city: viewModel.detailWeather.cityEnglish)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

