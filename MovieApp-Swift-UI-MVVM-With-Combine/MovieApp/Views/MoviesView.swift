//
//  MoviesView.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI

struct MoviesView: View {
    @State private var searchTerm = ""
    @State private var selectionIndex = 0
    @State private var tabs = ["NowPlaying","UpComing","Trending"]
    
    @ObservedObject  var  movieArray = MovieDownloadManager()
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectionStyle = .none
        
        UINavigationBar.appearance().backgroundColor = UIColor.clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .orange
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().largeTitleTextAttributes  = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(alignment: .leading) {
                    Text(tabs[selectionIndex])
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.red)
                        .padding(.top)
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.medium)
                        TextField("Search...", text: $searchTerm)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                }.padding(.horizontal)
                //MARK: - segmentControl
                
                VStack {
                    
                    Picker("_", selection: $selectionIndex) {
                        ForEach(0 ..< tabs.count) { index in
                            Text(tabs[index])
                                .font(.title)
                                .bold()
                                .tag(index)
                            
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selectionIndex) { (_) in
                            if selectionIndex == 0 {
                                movieArray.getNowPlaying()
                            } else if selectionIndex == 1 {
                                movieArray.getUpcoming()
                            } else if  selectionIndex == 2 {
                                movieArray.getPopular()
                            }
                        }.padding()
                    Spacer()
                    List{
                        ForEach(movieArray.movies.filter {
                            searchTerm.isEmpty ? true : $0.title?.lowercased().localizedStandardContains(searchTerm.lowercased()) ?? true}) { movie in
                                NavigationLink(destination: MovieDetailsView(movie: movie)) {
                                    MovieCell(movie: movie)                                    }.listRowBackground(Color.white)
                                
                            }
                    }.scrollContentBackground(.hidden)
                        .background {
                            Image(uiImage: UIImage())
                                .resizable()
                                .scaledToFit()
                                .padding()
                        }
                        .onAppear {
                            movieArray.getNowPlaying()
                        }
                    
                    Spacer()
                }.background(Color.white)
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
