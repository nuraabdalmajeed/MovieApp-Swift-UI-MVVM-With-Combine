//
//  Review.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import Foundation

struct ReviewResponse: Codable {
    var results: [Review]?
}
struct Review: Codable ,Identifiable {
    var id: String?
    var author: String?
    var content: String?
}
