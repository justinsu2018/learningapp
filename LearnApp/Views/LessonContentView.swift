//
//  LessonContentView.swift
//  LearnApp
//
//  Created by Justin Su on 10/10/21.
//

import SwiftUI

struct LessonContentView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                if (model.currentModule != nil) {
                    
                    ForEach(0..<model.currentModule!.content.lessons.count) { idx in
                        
                        NavigationLink(
                            destination:
                                LessonContentDetail()
                                .onAppear(perform:  {
                                    model.beginLesson(idx)
                                }),
                            label: {
                            LessonContentViewRow(idx: idx)
                        })
                        
                        
                    }
                }
            }
            .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
            
        }
        
    }
}

struct LessonContentView_Previews: PreviewProvider {
    static var previews: some View {
        LessonContentView()
    }
}
