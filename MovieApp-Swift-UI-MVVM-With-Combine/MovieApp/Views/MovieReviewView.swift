//
//  MovieReviewView.swift
//  MovieApp
//
//  Created by noura on 31/10/2022.
//

import SwiftUI
struct MovieReviewView: View {
    @State var movie: Movie
    
    @ObservedObject var reviewManger : MovieReviewManger
    
    init(movie:Movie){
        self.movie = movie
        self.reviewManger = MovieReviewManger(movie:movie)
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack(alignment:.top) {
            Color.black.opacity(0.7)
            List{
                ForEach(reviewManger.reviews) { review in
                    VStack {
                        Text(review.author ?? "")
                            .font(.title)
                            .bold()
                        Text(review.content ?? "")
                            .font(.body)
                            .lineLimit(nil)
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.clear)
                }
            }.scrollContentBackground(.hidden)
                .background {
                    Image(uiImage: UIImage())
                        .resizable()
                        .scaledToFit()
                    //                        .padding()
                }
                .onAppear {
                    reviewManger.getMovieReview()
                }.padding(.top, 84)
                .padding(.horizontal, 15)
        }.edgesIgnoringSafeArea(.all)
        
    }
    
}
