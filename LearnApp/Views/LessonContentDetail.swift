//
//  LessonContentDetail.swift
//  LearnApp
//
//  Created by Justin Su on 11/10/21.
//

import SwiftUI
import AVKit

struct LessonContentDetail: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostUrl + (lesson?.video ?? ""))
        
        VStack {
            
            
            if (url != nil) {
                VideoPlayer(player: AVPlayer(url: url!))
                    .cornerRadius(10)
            }
            
            // description
            CodeTextView()
            
            // next lesson
            if model.hasNextLesson() {
                Button(action: {
                    
                    model.nextLesson()
                    
                }, label: {
                    
                    ZStack {
                        
                        RetangleCard(color: .green)
                            .frame(height: 54)
                        
                        Text("Next Lesson \(model.currentModule!.content.lessons[model.currentLessonIndex+1].title)")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
                    .padding()
            }
            else {

                Button(action: {
                    
                    // take the back to the homeview
                    model.currentContentSelected = nil
                    
                }, label: {
                    
                    ZStack {
                        
                        RetangleCard(color: .red)
                            .frame(height: 54)
                        
                        Text("Complete")
                            .foregroundColor(Color.white)
                            .bold()
                    }
                })
                    .padding()
                
            }
            
            
        }
        .padding()
    }
}

struct LessonContentDetail_Previews: PreviewProvider {
    static var previews: some View {
        LessonContentDetail()
    }
}
