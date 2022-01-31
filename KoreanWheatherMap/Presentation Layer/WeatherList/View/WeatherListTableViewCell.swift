//
//  WeatherListTableViewCell.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/26.
//

import Foundation
import UIKit

class WeatherListTableViewCell: UITableViewCell {

    let cityTitleLabel = UILabel()
    let iconImageView = UIImageView()
    let temperatureLabel = UILabel()
    let humidityLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupViews()
    }
    
    func setupViews() {
        setupCityTitleLabel()
        setupIconImageView()
        setupTemperatureLabel()
        setupHumidityLabel()
    }
    
    func setupCityTitleLabel() {
        self.addSubview(cityTitleLabel)
        cityTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cityTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        cityTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        cityTitleLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        cityTitleLabel.textColor = .black
        
    }
    
    func setupIconImageView() {
        self.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: cityTitleLabel.trailingAnchor).isActive = true
        iconImageView.contentMode = .scaleAspectFit
        

    }
    
    func setupTemperatureLabel() {
        self.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
        temperatureLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        temperatureLabel.textColor = .black
    }
    
    func setupHumidityLabel() {
        self.addSubview(humidityLabel)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        humidityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        humidityLabel.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
