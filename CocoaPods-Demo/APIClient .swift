//
//  APIClient .swift
//  CocoaPods-Demo
//
//  Created by Brendon Crowe on 4/10/23.
//

import Foundation
import Alamofire // similar to import network helper


struct APIClient {
    static func fetchCockTail(completion:  @escaping (Result<Cocktail, Error>) -> ()) {
        let endpointURLString = "https://www.thecocktaildb.com/api/json/v1/1/random.php"
        
        guard let url = URL(string: endpointURLString) else { return }
        AF.request(url).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else if let data = response.data {
                do {
                    let results = try JSONDecoder().decode(DrinksWrapper.self, from: data)
                    if let cocktail = results.drinks.first {
                        completion(.success(cocktail))
                    }
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
}
