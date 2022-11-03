//
//  DiscoverView.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI

struct DiscoverView: View {
    @State private var offset: CGFloat = 0
    @State private var index = 0
    @State  var showDetails = false
    @ObservedObject private var discoverManaged = MovieDownloadManager()
    let spacing: CGFloat = 10
    var body: some View {
        GeometryReader { (geometry) in
            return ScrollView(.horizontal, showsIndicators: true){
                HStack(spacing: spacing) {
                    ForEach(discoverManaged.movies) { movies in
                        //CardView
                        cardView(movie: movies)
                            .frame(width: geometry.size.width)
                    }
                }
            }.content.offset(x: CGFloat(self.offset))
                .frame(width: geometry.size.width, alignment:.leading)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            offset = value.translation.width - geometry.size.width * CGFloat(index)
                        })
                        .onEnded({ value in
                            if -value.predictedEndTranslation.width > geometry.size.width / 2 , index < discoverManaged.movies.count - 1 {
                                index += 1
                            }
                            if value.predictedEndTranslation.width > geometry.size.width / 2 , index > 0  {
                                index -= 1
                            }
                            withAnimation {
                                offset =  -( geometry.size.width + spacing) * CGFloat(index)
                                
                            }
                        })
                ).onAppear {
                    discoverManaged.getPopular()
                }
        }
        
    }
    
    private func cardView(movie:Movie) -> some View {
        ZStack(alignment: .bottom){
            //poster view
            posterView(movie: movie)
            detailsView(movie: movie)
        }.shadow(radius: 12.0)
            .cornerRadius(12.0)
    }
    
    private func posterView(movie:Movie) -> some View{
        AsyncImage(url: URL(string: movie.concatPosterPath)!) {
            Rectangle().foregroundColor(Color.gray.opacity(0.4))
            
        }image: { image in
            Image(uiImage: image)
                .resizable()
        }.animation(.easeInOut, value: 0.5)
            .transition(.scale)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.7,alignment: .center)
            .cornerRadius(20)
            .shadow(radius: 15)
            .overlay(
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.clear,.clear]), startPoint: .center, endPoint: .bottom))
                    .clipped()
            ).cornerRadius(12.0)
    }
    
    private func detailsView(movie:Movie) -> some View {
        VStack(alignment: .leading){
            Spacer()
            VStack(alignment: .leading,spacing: 10){
                Text(movie.titleWithLanguage)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top)
                Text(movie.overview ?? "")
                    .font(.system(size:15))
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                    .padding(.top)
                NavigationLink(destination: MovieDetailsView(movie: movie)) {
                    Text("details")
                        .bold()
                        .padding()
                        .foregroundColor(Color.black)
                        .background( Color.orange)
                        .cornerRadius(12)
                }.padding()
            }.background(Color.white.opacity(0.6))
                .cornerRadius(12)
                .lineLimit(5)
        }.padding()
        
    }
    
}
struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
