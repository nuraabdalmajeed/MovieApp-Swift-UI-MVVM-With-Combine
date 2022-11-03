//
//  MovieReviewManger.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI

final class MovieReviewManger: ObservableObject{
    @Published var reviews = [Review]()
    
    private var movie: Movie
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    
    init( movie: Movie) {
        self.movie = movie
    }
    
    func getMovieReview() {
        getReview(for: movie)

    }
    
    private func  getReview(for movie: Movie) {
        let urlString = "\(Self.baseURL)\(movie.id ?? 100)/reviews?api_key=\(API.key)&language=en-US"

        NetworkManger<ReviewResponse>.fetch(from: urlString) { (result) in
            switch result {
            case .success(let reviewResponse):
                self.reviews = reviewResponse.results ?? []
            case .failure(let error):
                print("error\(error)")
            }
        }
    }
}
