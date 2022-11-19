//
//  TrendingTvsViewModel.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 19/11/22.
//

import Foundation

class TvViewModel {
    
    static let shared = TvViewModel()
    
    func fetchTrendingTvs() {
        let apiService = APIService(urlPath: "/3/trending/tv/week")
        apiService.getData { (result: Result<TrendingTvsResponse, APIError>) in
            switch result {
            case .success(let data):
                print(data.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}
