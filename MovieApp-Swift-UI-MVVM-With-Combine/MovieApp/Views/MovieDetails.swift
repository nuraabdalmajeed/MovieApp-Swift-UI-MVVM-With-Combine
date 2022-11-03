//
//  MovieDetails.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI
struct MovieDetailsView: View{
    @StateObject private var loader: ImageLoader
    @ObservedObject private var movieManger = MovieDownloadManager()
    var movie: Movie
    init( movie: Movie ) {
        self.movie = movie
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string:movie.concatPosterPath)!, cache: Environment(\.imageCache).wrappedValue))
        
    }
    
    var body:some View {
        ZStack(alignment: .top) {
            backgroundView
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading){
                    headerView
                    moviePosterView
                    movieOverview
                    reviewLink
                    castInfo
                    Spacer()
                }.padding(.top, 84)
                    .padding(.horizontal, 32)
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    private var backgroundView:some View {
        imageView.onAppear {
            loader.load()
        }.blur(radius: 100)
    }
    
    private var imageView:some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image ?? #imageLiteral(resourceName: "empty"))
                    .resizable()
            } else {
                Rectangle().foregroundColor(Color.gray)
            }
        }
    }
    
    private var headerView:some View {
        VStack {
            Text(movie.titleWithLanguage).font(.subheadline)
            Text("Release Date: \(movie.releaseDate ?? "")").font(.subheadline)
        }.foregroundColor(.white)
    }
    
    private var moviePosterView:some View {
        HStack(alignment: .center) {
            Spacer()
            imageView.frame(width: 200, height: 320).cornerRadius(20)
            Spacer()
        }
    }
    
    private var movieOverview:some View {
        Text(movie.overview ?? "")
            .font(.body)
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
            .padding(.top, 16)
    }
    
    private var reviewLink:some View {
        VStack {
            Divider()
            NavigationLink(destination: MovieReviewView(movie: movie)){
                HStack{
                    Text("Reviews")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                    //                    Text(movie.title ?? "")
                }
            }
            Divider()
            
        }
        
    }
    private var castInfo:some View {
        VStack(alignment: .leading) {
            Text("Cast").foregroundColor(.white)
            ScrollView(.horizontal,showsIndicators: false){
                HStack(alignment: .top,spacing:  20) {
                    ForEach(movieManger.cast){ cast in
                        VStack {
                            AsyncImage(url: URL(string: cast.concatProfilePath  )!) {
                                Rectangle().foregroundColor(Color.gray.opacity(0.4))
                            }image: { image in
                                Image(uiImage: image)
                                    .resizable()
                            }.frame(width: 100, height: 160)
                                .animation(.easeInOut, value: 0.5)
                                .transition(.opacity)
                                .scaledToFill()
                                .cornerRadius(15)
                                .shadow(radius: 15)
                            Text("\(cast.name ?? "_") as \(cast.character ?? "_")")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 100)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }.onAppear{
            movieManger.getCast(movie: movie)
        }
    }
}
