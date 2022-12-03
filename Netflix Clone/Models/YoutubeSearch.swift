//
//  YoutubeSearch.swift
//  Netflix Clone
//
//  Created by Ryan Adi Putra on 01/12/22.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [YTVideo]
}

struct YTVideo: Codable {
    let id: YTVideoElement
}

struct YTVideoElement: Codable {
    let kind: String
    let videoId: String
}

struct PosterPreview {
    let title: String
    let overview: String
    let youtubeView: YTVideoElement
}
