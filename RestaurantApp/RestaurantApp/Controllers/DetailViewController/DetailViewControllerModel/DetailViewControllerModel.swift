//
//  DetailViewControllerModel.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 15.06.2022.
//

import UIKit


class DetailViewControllerModel {
    
    var model: DetailViewControllerModel?
    var place: Place
    
    init(place: Place) {
        self.place = place
    }
    
    func cornerRadiusForImage() -> CGFloat {
        return 6
    }
    
    
    
    func imageURL() -> String {
        let url = "\(place.categories?.first?.icon?.prefix ?? "")120\(place.categories?.first?.icon?.suffix ?? "")"
        return url
    }
}
