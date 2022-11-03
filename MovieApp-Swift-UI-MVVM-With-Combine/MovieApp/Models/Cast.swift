//
//  Cast.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import Foundation
struct CastResponse: Codable {
    var cast: [Cast]?
}

struct Cast: Codable, Identifiable {
    var id: Int?
    var name: String?
    var character: String?
    var profilePath: String?
    var concatProfilePath: String {
        if let path = profilePath {
            return "https://image.tmdb.org/t/p/original/\(path)"
        } else {
            return "https://picsum.photos/200/300"
        }
    }
}
