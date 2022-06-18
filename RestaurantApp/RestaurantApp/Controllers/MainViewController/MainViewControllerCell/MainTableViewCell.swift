//
//  MainTableViewCell.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 15.06.2022.
//

import UIKit


class MainTableViewCell: UITableViewCell {
    

    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var locationLabel: UILabel!
    @IBOutlet weak private var categoryLabel: UILabel!
    
    private var viewModel: MainTableViewCellModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewModel = MainTableViewCellModel()
    }
    
    func configure(with model: Place) {
        nameLabel.text = model.name
        locationLabel.text = model.location?.address
        categoryLabel.text = model.categories?.first?.name
    }
    
     
    
}

