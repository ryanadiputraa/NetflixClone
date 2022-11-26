//
//  Movie.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 15/11/22.
//

import Foundation

struct PosterResponse: Codable {
    let results: [Poster]
}

struct Poster: Codable, Identifiable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_data: String?
    let vote_average: Double
}

struct PosterViewModel {
    let posterTitle: String
    let posterImageURL: String
}
