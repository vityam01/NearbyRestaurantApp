//
//  APIManager.swift
//  RestaurantApp
//
//  Created by Vitya Mandryk on 15.06.2022.
//

import Foundation


class APIManager {

//  let imageURL = "https://fastly.4sqi.net/img/general/original/1049719_PiLE0Meoa27AkuLvSaNwcvswnmYRa0vxLQkOrpgMlwk.jpg" // Model(prefix) + original + Model(suffix)

    static let shared = APIManager()
    

    //TODO: url to param,
    func getRequest<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void)  {
        // Create URL Request
        var request = URLRequest(url: url)
        // Set HTTP Request Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("fsq38sMRDJ74n9decZWUIY3rziW4fwM9WTDUtUL7xE/Dg1Q=", forHTTPHeaderField: "Authorization")
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil  else { return }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch  {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    

}
