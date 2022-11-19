//
//  TrendingTvsViewModel.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 19/11/22.
//

import Foundation

class TvViewModel {
    
    static let shared = TvViewModel()
    
    func fetchTrendingTvs(completion: @escaping (Result<[Poster], APIError>) -> Void) {
        let apiService = APIService(urlPath: "/3/trending/tv/week")
        apiService.getData { (result: Result<PosterResponse, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
