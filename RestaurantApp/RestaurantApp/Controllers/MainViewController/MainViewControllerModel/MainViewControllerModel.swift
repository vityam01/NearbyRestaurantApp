//
//  MainViewControllerModel.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 15.06.2022.
//

import UIKit


class MainViewControllerModel {
    
    var places: [Place] = [Place]()
    
    
    func heightForRow() -> CGFloat {
        return 100
    }
    
    let defaultURL = URL(string: "https://api.foursquare.com/v3/places/search?query=restaurants&limit=50")
    
    func getDataForElements(completion: @escaping () -> Void) {
        guard let url = defaultURL else { return }
        APIManager.shared.getRequest(url: url) { [ weak self ] (result: Result<Empty, Error>) in
            switch result {
            case .success(let data):
                self?.places = data.results
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func searchData(query: String ,completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.foursquare.com/v3/places/search?query=\(query)&limit=50") else { return }
        APIManager.shared.getRequest(url: url) { [ weak self ] (result: Result<Empty, Error>) in
            switch result {
            case .success(let data):
                self?.places = data.results
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func filterDataByID(id: Int, completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.foursquare.com/v3/places/search?categories=\(id)") else { return }
        APIManager.shared.getRequest(url: url) { (result: Result<Empty, Error>)  in
            switch result {
            case .success(let success):
                self.places = success.results
                completion()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func getCell(indexPath: IndexPath) -> Place {
        return places[indexPath.row]
    }
    
    func getData(indexPath: IndexPath) -> DetailViewControllerModel {
        let vcModel = DetailViewControllerModel(place: getCell(indexPath: indexPath))
        return vcModel
    }
    
    func numberOfRows() -> Int {
        return places.count
    }
    
    
    
}




