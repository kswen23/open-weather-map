//
//  FilterTatbleViewCell.swift
//  KoreanWheatherMap
//
//  Created by 김성원 on 2022/01/31.
//

import Foundation
import UIKit

class FilterTableViewCell: UITableViewCell {
    
    let itemLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupItemLabel()
    }
 
    func setupItemLabel() {
        self.addSubview(itemLabel)
        itemLabel.translatesAutoresizingMaskIntoConstraints = false
        itemLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        itemLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        itemLabel.textColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
