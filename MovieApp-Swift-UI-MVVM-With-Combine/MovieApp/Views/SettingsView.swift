//
//  SettingsView.swift
//  MovieApp
//
//  Created by AMN on 10/29/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isPresented :Bool
    
    @State private var selection = 1
    @State private var email = ""
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $selection, label: Text("Favorite Genre")){
                    Text("Action").tag(1)
                    Text("comedy").tag(2)
                    Text("Horror").tag(3)
                }
                
                Section(header: Text("Email")){
                    TextField("Email", text: $email)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.emailAddress)
                }
                
                Button(action: {
                    isPresented.toggle()
                }){
                    Text("Save")
                }
            }.navigationTitle("Settings")
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(isPresented: Binding<Bool>.constant(false))
    }
}
