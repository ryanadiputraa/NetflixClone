//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 15/11/22.
//

import Foundation

struct Constants {
    static let API_KEY = "c63a39f4faa3403e1a8392caf5a8bdb8"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case invalidResponseStatus
    case dataTaskError
    case corruptData
    case decodingError
}

class APIService {
    
    static let shared = APIService()
    
    func fetchData<T: Decodable>(urlPath: String, urlParams: String = "", completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)\(urlPath)?api_key=\(Constants.API_KEY)\(urlParams)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponseStatus))
                return
            }
            guard error == nil else {
                completion(.failure(.dataTaskError))
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.corruptData))
                return
            }
            
            
        }
        task.resume()
    }
    
}
