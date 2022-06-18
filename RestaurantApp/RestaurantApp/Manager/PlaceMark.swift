//
//  PlaceMark.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 18.06.2022.
//

import Foundation
import MapKit


class PlaceMark: NSObject, MKAnnotation {
    
    let title: String?
    let location: String?
    let descriptionLinae: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, location: String?, descriptionLinae: String? ,coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.location = location
        self.descriptionLinae = descriptionLinae
        self.coordinate = coordinate
        super.init()
    }
    
}
