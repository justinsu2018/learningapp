//
//  LessonContentViewRow.swift
//  LearnApp
//
//  Created by Justin Su on 10/10/21.
//

import SwiftUI

struct LessonContentViewRow: View {
    
    @EnvironmentObject var model:ContentModel
    var idx:Int
    
    var lessson: Lesson {
        if model.currentModule != nil &&
            idx < model.currentModule!.content.lessons.count {
            return model.currentModule!.content.lessons[idx]
        }
        else
        {
            return Lesson(id: 0, title: "", video: "", duration: "", explanation: "")
        }
    }
    
    var body: some View {
        
        let lesson = lessson
        
        ZStack(alignment: .leading) {
            
            Rectangle()
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                .frame(height: 66)
            
            
            HStack(spacing:30) {
                
                Text("\(idx+1)")
                    .bold()
                
                VStack(alignment: .leading) {
                    Text(lesson.title)
                        .bold()
                    Text(lesson.duration)
                }
            }
            .padding()
        }
        .padding(.bottom, 5)
        
    }
}
