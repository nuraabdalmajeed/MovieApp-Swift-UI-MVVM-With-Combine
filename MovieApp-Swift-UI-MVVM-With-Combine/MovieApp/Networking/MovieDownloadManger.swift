//
//  MovieDownloadManger.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI

final class MovieDownloadManager: ObservableObject{
    @Published var movies = [Movie]()
    @Published var cast = [Cast]()
    
    static var baseURL = "https://api.themoviedb.org/3/movie/"
    
    func getNowPlaying() {
        getMovies(movieURL: .nowPlaying)
    }
    
    func getUpcoming() {
        getMovies(movieURL: .upcoming)
        
    }
    
    func getPopular() {
        getMovies(movieURL: .popular)
        
    }
    
    func  getCast(movie: Movie) {
        let urlString = "\(Self.baseURL)\(movie.id ?? 100)/credits?api_key=\(API.key)&language=en-US"
        NetworkManger<CastResponse>.fetch(from: urlString) { (result) in
            switch result {
            case .success(let castResponse):
                self.cast = castResponse.cast ?? []
            case .failure(let error):
                print("error\(error)")
            }
        }
    }
    
    private func  getMovies(movieURL: MovieCases) {
        NetworkManger<MovieResponse>.fetch(from: movieURL.urlString) { (result) in
            switch result {
            case .success(let movieResponse):
                self.movies = movieResponse.results ?? []
            case .failure(let error):
                print("error\(error)")
            }
        }
    }
}
