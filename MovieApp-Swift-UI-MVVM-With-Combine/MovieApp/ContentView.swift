//
//  ContentView.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI

struct ContentView: View {
    @State private var ShowSettings = false
    var body: some View {
        NavigationView{
            Group{
                HomeTabView()
            }.navigationBarTitle("Movies", displayMode: .automatic)
                .navigationBarItems( trailing: HStack{
                    setting
                })
                .sheet(isPresented: $ShowSettings, content:{
                    SettingsView(isPresented: $ShowSettings)
                })
        }
    }
    private var setting : some View {
        Button(action: {
            ShowSettings.toggle()
        }, label: {
            HStack{
                Image(systemName: "gear")
                    .imageScale(.large)
                    .foregroundColor(.gray)
            }
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
