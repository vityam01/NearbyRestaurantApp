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
        print(place.categories?.first?.id)
        let url = "https://api.foursquare.com/v2/photos/original/\(String(describing: place.categories?.first?.id))"
        return url
    }
}
