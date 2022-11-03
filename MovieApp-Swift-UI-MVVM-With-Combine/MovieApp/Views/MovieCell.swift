//
//  MovieCell.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI

struct MovieCell: View {
    var movie : Movie
    var body: some View {
        HStack (alignment: .top, spacing:  20) {
            moviePoster
            VStack(alignment: .leading,spacing: 0) {
                movieTitle
                HStack {
                    movieVote
                    movieReleaseDate
                }
                movieOverView
            }
        }
    }
    
    private var moviePoster: some View {
        AsyncImage(url: URL(string: movie.concatPosterPath )!) {
            Rectangle().foregroundColor(Color.gray.opacity(0.4))
            
        }image: { (image) -> Image in
            Image(uiImage: image).resizable()
        }
        .frame(width: 100, height: 160)
        .animation(.easeInOut(duration: 0.5), value: 0.5)
        .transition(.opacity)
        .scaledToFill()
        .cornerRadius(15)
        .shadow(radius: 15)
    }
    
    private var movieTitle: some View {
        Text(movie.titleWithLanguage)
            .font(.system(size:15))
            .bold()
            .foregroundColor(.blue)
        
    }
    
    private var movieVote: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(movie.concatVoteAverage))
                .stroke(Color.orange,lineWidth: 4)
                .frame(width: 50)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.orange.opacity(0.2),lineWidth: 4)
                .frame(width: 50)
                .rotationEffect(.degrees(-90))
            Text(String.init(format: "%0.2f", movie.voteAverage ?? 0.0))
                .foregroundColor(.orange)
                .font(.subheadline)
        }.frame(height: 80)
    }
    
    private var movieReleaseDate: some View {
        
        Text(movie.releaseDate ?? "")
            .font(.subheadline)
            .foregroundColor(.black)
    }
    
    private var movieOverView: some View {
        Text(movie.overview ?? "")
            .font(.body)
            .foregroundColor(.gray)
            .lineLimit(4)
        
    }
}
