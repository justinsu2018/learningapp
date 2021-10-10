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
    
    var body: some View {
        
        let lesson = model.currentModule!.content.lessons[idx]
        
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
