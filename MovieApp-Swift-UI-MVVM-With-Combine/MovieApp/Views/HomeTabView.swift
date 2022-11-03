//
//  HomeTabView.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI

struct HomeTabView: View {
    enum Tabs: Int {
        case movie
        case discover
    }
    
    @State private var  selectedTab = Tabs.movie
    
    var body: some View {
        TabView(selection: $selectedTab){
            MoviesView().tabItem{
                tabBarItem(title: "Movies", image: "film")
            }.tag(Tabs.movie)
            
            DiscoverView().tabItem{
                tabBarItem(title: "Discover", image: "square.stack")
            }.tag(Tabs.discover)
        }
        
    }
    
    private func tabBarItem(title :String, image: String) -> some View{
        VStack {
            Image(systemName: image)
                .imageScale(.large)
            Text(title)
            
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
