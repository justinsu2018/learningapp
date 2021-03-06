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
                            VStack(spacing:10) {
                                
                                NavigationLink(
                                    destination:
                                        LessonContentView()
                                        .onAppear(perform: {
                                            model.beginModule(m_module.id)
                                        }),
                                    tag: m_module.id,
                                    selection: $model.currentContentSelected) {
                                        //Learning Card
                                        HomeViewRow(image: m_module.content.image,
                                                    title: "Learn \(m_module.category)",
                                                    description: m_module.content.description,
                                                    count: "\(m_module.content.lessons.count) Lessons",
                                                    time: m_module.content.time)
                                    }

                                NavigationLink(
                                    destination:
                                        TestView()
                                        .onAppear(perform: {
                                            model.beginTest(m_module.id)
                                        }),
                                    tag: m_module.id,
                                    selection: $model.currentTestSelected)
                                {
                                    //Test Card
                                    HomeViewRow(image: m_module.test.image,
                                                title: "\(m_module.category) Test",
                                                description: m_module.test.description,
                                                count: "\(m_module.test.questions.count) Lessons",
                                                time: m_module.test.time)
                                    
                                }
                                
                            }
                            .padding(.bottom, 5)
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
            }
            .navigationTitle("Get Started")
        }
        .navigationViewStyle(.stack)
        .onChange(of: model.currentContentSelected, perform: {changeValue in
            if changeValue == nil {
                model.currentModule = nil
            }
        })
        /*
        .onChange(of: model.currentTestSelected, perform: {changeValue in
            if changeValue == nil {
                model.currentModule = nil
            }
        })
         */
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
