//
//  TrendingMoviesViewModel.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 19/11/22.
//

import Foundation

class MovieViewModel {
    
    static let shared = MovieViewModel()
    
    func fetchTrendingMovies(completion: @escaping (Result<[Poster], APIError>) -> Void) {
        let apiService = APIService(urlPath: "/3/trending/movie/week")
        apiService.getData { (result: Result<PosterResponse, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchUpcomingMovies(completion: @escaping (Result<[Poster], APIError>) -> Void) {
        let apiService = APIService(urlPath: "/3/movie/upcoming", urlParams: "&languange=en-US&page=1")
        apiService.getData { (result: Result<PosterResponse, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPopularMovies(completion: @escaping (Result<[Poster], APIError>) -> Void) {
        let apiService = APIService(urlPath: "/3/movie/popular", urlParams: "&languange=en-US&page=1")
        apiService.getData { (result: Result<PosterResponse, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchTopRatedMovies(completion: @escaping (Result<[Poster], APIError>) -> Void) {
        let apiService = APIService(urlPath: "/3/movie/top_rated", urlParams: "&languange=en-US&page=1")
        apiService.getData { (result: Result<PosterResponse, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func discoverMovies(completion: @escaping (Result<[Poster], APIError>) -> Void) {
        let apiService = APIService(urlPath: "/3/discover/movie", urlParams: "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate")
        apiService.getData { (result: Result<PosterResponse, APIError>) in
            switch result {
            case .success(let data):
                completion(.success(data.results))
            case .failure(let error):
                completion(.failure((error)))
            }
        }
    }
}
