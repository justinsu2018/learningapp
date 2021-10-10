//
//  ContentView.swift
//  LearnApp
//
//  Created by Justin Su on 8/10/21.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        NavigationView {
            
            VStack(alignment: .leading) {
                Text("What do you want to do today?")
                ScrollView {
                    LazyVStack {
                        ForEach(model.modules) {m_module in
                            VStack(spacing:20) {
                                //Learning Card
                                HomeViewRow(image: m_module.content.image,
                                            title: "Learn \(m_module.category)",
                                            description: m_module.content.description,
                                            count: "\(m_module.content.lessons.count) Lessons",
                                            time: m_module.content.time)
                                
                                //Test Card
                                HomeViewRow(image: m_module.test.image,
                                            title: "Learn \(m_module.category)",
                                            description: m_module.test.description,
                                            count: "\(m_module.test.questions.count) Lessons",
                                            time: m_module.test.time)
                            }
                        }
                    }
                }
                
            }
            .navigationTitle("Get Started")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
