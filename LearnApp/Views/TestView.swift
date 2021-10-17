//
//  TestView.swift
//  LearnApp
//
//  Created by Justin Su on 14/10/21.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    @State var selectedAnswerIndex:Int?
    @State var numCorrect = 0
    @State var submited = false
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack(alignment: .leading) {
                
                // Question number
                Text("Question \(model.currentQuestionIndex + 1) of \(model.currentModule!.test.questions.count ?? 0)")
                    .padding(.leading, 5)
                
                // Question
                CodeTextView()
                    .padding(.horizontal, 5)
                
                // Answers
                ScrollView {
                    VStack {
                        ForEach(0..<model.currentQuestion!.answers.count, id: \.self) { index in
                            
                            Button {
                                selectedAnswerIndex = index
                            } label: {
                                ZStack {
                                    
                                    if submited == false {
                                        
                                        RetangleCard(color: index == selectedAnswerIndex ? .gray : .white)
                                            .frame(height: 48)
                                        
                                    }
                                    else
                                    {
                                        
                                        // answer has been submitted
                                        if index == selectedAnswerIndex &&
                                            index == model.currentQuestion!.correctIndex {
                                            
                                            RetangleCard(color: .green)
                                                .frame(height: 48)
                                        }
                                        else if index == selectedAnswerIndex &&
                                                    index != model.currentQuestion!.correctIndex {
                                            
                                            RetangleCard(color: .red)
                                                .frame(height: 48)
                                        }
                                        else if index == model.currentQuestion!.correctIndex {
                                            
                                            // this button is the correct answer
                                            // show a green
                                            RetangleCard(color: .green)
                                                .frame(height: 48)
                                        }
                                        else
                                        {
                                            RetangleCard(color: .white)
                                                .frame(height: 48)
                                        }
                                        
                                    }
                                    
                                    Text(model.currentQuestion!.answers[index])
                                }
                            }.disabled(submited)
                            
                        }
                    }
                    .accentColor(.black)
                    .padding()
                }
                
                // Submit Button
                Button {
                    
                    // check if answer has been submitted
                    if submited == true {
                        // answer has already been submitted, move to next question
                        model.nextQuestion()
                        
                        // reset properties
                        submited = false
                        selectedAnswerIndex = nil
                    }
                    else
                    {
                        // submit the answer
                        if selectedAnswerIndex == model.currentQuestion!.correctIndex {
                            numCorrect += 1
                        }
                        
                        submited = true
                    }
                    

                    
                } label: {
                    ZStack {
                        RetangleCard(color: .green)
                            .frame(height: 48)
                        
                        Text(buttonText)
                            .bold()
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                .disabled(selectedAnswerIndex == nil)
                
            }
            .accentColor(.black)
            .padding()
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
            /*
             .onAppear(perform: {
             model.beginTest(module.id)
             })
             */
            
            
        }
        else
        {
            // if current question is nil, we show the result view
            TestResultView(numCorrect: numCorrect)
        }
        
    }
    
    var buttonText:String {
        
        if submited == true {
            
            if model.currentQuestionIndex + 1 == model.currentModule!.test.questions.count {
               return "Finish"
            }
            else {
                return "Next"
            }
            
        }
        else {
            return "Submit"
        }
    }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

