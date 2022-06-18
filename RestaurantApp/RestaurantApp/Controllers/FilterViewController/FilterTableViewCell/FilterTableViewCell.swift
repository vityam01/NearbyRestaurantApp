//
//  FilterTableViewCell.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 16.06.2022.
//

import UIKit



final class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak private var kindNameLabel: UILabel!
    
    func configure(data: String) {
        kindNameLabel.text = data
    }
    
    
}
