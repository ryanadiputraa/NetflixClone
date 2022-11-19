//
//  TrendingMoviesViewModel.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 19/11/22.
//

import Foundation

class MovieViewModel {
    
    static let shared = MovieViewModel()
    
    func fetchTrendingMovies() {
        let apiService = APIService(urlPath: "/3/trending/movie/week")
        apiService.getData { (result: Result<MovieResponse, APIError>) in
            switch result {
            case .success(let data):
                print(data.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchUpcomingMovies() {
        let apiService = APIService(urlPath: "/3/movie/upcoming", urlParams: "&languange=en-US&page=1")
        apiService.getData { (result: Result<MovieResponse, APIError>) in
            switch result {
            case .success(let data):
                print(data.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPopularMovies() {
        let apiService = APIService(urlPath: "/3/movie/popular", urlParams: "&languange=en-US&page=1")
        apiService.getData { (result: Result<MovieResponse, APIError>) in
            switch result {
            case .success(let data):
                print(data.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}
