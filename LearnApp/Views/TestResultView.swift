//
//  TestResultView.swift
//  LearnApp
//
//  Created by Justin Su on 18/10/21.
//

import SwiftUI

struct TestResultView: View {
    
    @EnvironmentObject var model:ContentModel
    var numCorrect:Int
    
    var body: some View {
        
        VStack
        {
            Spacer()
            
            Text("Doing great!")
                .font(.title)
            
            Spacer()
            
            Text("You got \(numCorrect) out of \(model.currentModule?.test.questions.count ?? 0) questions")
            
            Spacer()
            
            Button {
               
                // send you back to the homeview
                model.currentTestSelected = nil
                
            } label: {
                
                ZStack{
                    RetangleCard(color: .green)
                        .frame(height:48)
                    
                    Text(resultHeading)
                        .bold()
                        .foregroundColor(.white)
                }
            }
            
        }
        .padding()
        
    }
    
    var resultHeading:String {
        guard model.currentModule != nil else {
            return ""
        }
        
        let pct = Double(numCorrect)/Double(model.currentModule!.test.questions.count)
        
        if pct > 0.5
        {
            return "Awesome!"
        }
        else if pct > 0.2
        {
            return "Doing great!"
        }
        else
        {
            return "Keep learning."
        }
    }
}

struct TestResultView_Previews: PreviewProvider {
    static var previews: some View {
        TestResultView(numCorrect: 0)
    }
}
