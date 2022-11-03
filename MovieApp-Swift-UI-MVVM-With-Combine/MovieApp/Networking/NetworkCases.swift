//
//  NetworkCases.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import Foundation
struct API {
    static let key = "32c6fcb48eb9f8aba840a7e9dbe4188c"
}
enum MovieCases: String {
    case nowPlaying = "now_playing"
    case upcoming = "upcoming"
    case popular = "popular"
    public var urlString: String {
        "\(MovieDownloadManager.baseURL)\(self.rawValue)?api_key=\(API.key)&language=en-US&page=1"
    }
}
