//
//  FilterViewControllerModel.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 16.06.2022.
//

import UIKit


class FilterViewControllerModel {
    
    let titleText = "Select Category"
    let categoriesKind: [String] = ["Restaurant","Bar","Fast Food Restaurant","French Restaurant","Italian Restaurant", "Greek Restaurant"]
    let categoriesID: [Int] = [13065, 13003, 13145, 13148, 13236, 13177]
    var places: [Place] = [Place]()
    
    
    
    func heightForRow() -> CGFloat {
        return 50
    }
 
    func getCategoriesID(indexPath: IndexPath) -> Int {
        return categoriesID[indexPath.row]
    }
    
    func numberOfrows() -> Int {
        return categoriesKind.count
    }
    
    func setData(indexPath: IndexPath) -> String {
        return categoriesKind[indexPath.row]
    }
    
    
    
}
