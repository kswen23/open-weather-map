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
        cityTitleLabel.minimumScaleFactor = cityTitleLabel.frame.width

//        cityTitleLabel.widthAnchor.constraint(equalToConstant: 110).isActive = true
//        cityTitleLabel.sizeToFit()
        cityTitleLabel.textColor = .black
        
    }
    
    func setupIconImageView() {
        self.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: cityTitleLabel.trailingAnchor, constant: 10).isActive = true
        iconImageView.contentMode = .scaleAspectFit

    }
    
    func setupTemperatureLabel() {
        self.addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        temperatureLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
        

    }
    
    func setupHumidityLabel() {
        self.addSubview(humidityLabel)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        humidityLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        humidityLabel.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 10).isActive = true

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
