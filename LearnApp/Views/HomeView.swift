//
//  ContentView.swift
//  LearnApp
//
//  Created by Justin Su on 8/10/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var mode:ContentModel
    
    var body: some View {
        
        
        Text("Hello, world!")
            .padding()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
