//
//  ContentModel.swift
//  LearnApp
//
//  Created by Justin Su on 8/10/21.
//

import Foundation

class ContentModel: ObservableObject {
    
    // list of modules
    @Published var modules = [Module]()
    
    // current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // current question
    @Published var currentQuestion: Question?
    var currentQuestionIndex = 0
    
    // current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // current lesson explanation
    @Published var lessonExplanation = NSAttributedString()
    
    // Current selcted content and test
    @Published var currentContentSelected: Int?
    @Published var currentTestSelected:Int?
    
    
    var styleData: Data?
    
    init() {
        
        // parse local included json data
        getLocalData()
        
        // download remote json file and parse data
        getRemoteData()
    }
    
    // data methods
    func getLocalData() {
        
        let jsonUrl = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
            let jsonData = try Data(contentsOf: jsonUrl!)
            
            let jsonDecorder = JSONDecoder()
            let modules = try jsonDecorder.decode([Module].self, from: jsonData)
            
            self.modules = modules
            
        }
        catch {
            print("Couldn't parse local data:\(error)")
        }
        
        let styleUrl = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            let styledata = try Data(contentsOf: styleUrl!)
            
            self.styleData = styledata;
        }
        catch {
            print ("Couldn't parse style data:\(error)")
        }
    }
    
    func getRemoteData() {
        let urlString = "https://raw.githubusercontent.com/justinsu2018/learningapp-data/main/data2.json"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            
            // couldn't create url
            return
        }
        
        let request = URLRequest(url: url!)
        
        // get the sesiion and kick of the task
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            // check if there is an error
            guard error == nil else {
                return
            }
            
            //handle response
            
            do {
                // create json decorder
                let decorder = JSONDecoder()
                
                // decord
                let module = try decorder.decode([Module].self, from: data!)
                
                self.modules += module
            }
            catch {
                
            }
            
        })
        
        // kick of datatask
        dataTask.resume()
    }
    
    func beginModule(_ moduleid:Int)
    {
        
        // find index of this module id
        for Index in 0..<modules.count {
            
            if modules[Index].id == moduleid {
                
                currentModuleIndex = Index
                break
                
            }
        }
        
        // set the current module
        currentModule = modules[currentModuleIndex]
        
    }
    
    func beginLesson(_ lessonIndex:Int)
    {
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else
        {
            currentLessonIndex = 0
        }
        
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonExplanation = addStyling(currentLesson!.explanation)
    }
    
    func nextLesson()
    {
        currentLessonIndex += 1
        
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
        }
        else
        {
            currentLessonIndex = 0
            currentLesson = nil
        }
    }
    
    func nextQuestion()
    {
        // advance question index
        currentQuestionIndex += 1
        
        // check it's within the range of questions
        if (currentQuestionIndex < currentModule!.test.questions.count)
        {
            // set the current question
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            lessonExplanation = addStyling(currentQuestion!.content)
        }
        else
        {
            currentQuestionIndex = 0
            currentQuestion = nil
        }
    }
    
    func beginTest(_ moduleId:Int) {
        
        // Set the current module
        beginModule(moduleId)
        
        // Set the current question
        currentQuestionIndex = 0
        
        // if there are questions set the current question value to test 1
        if currentModule?.test.questions.count ?? 0 > 0 {
            currentQuestion = currentModule!.test.questions[currentQuestionIndex]
            
            //　set the question content as well
            lessonExplanation = addStyling(currentQuestion!.content)
        }
        
    }
    
    func hasNextLesson() -> Bool {
        
        if currentLessonIndex+1 < currentModule!.content.lessons.count {
            return true
        }
        
        return false
    }
    
    private func addStyling(_ htmlString:String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        if self.styleData != nil {
            data.append(self.styleData!)
        }
        
        data.append(Data(htmlString.utf8))
        
        do {
            
            let attributedString = try NSAttributedString(
                data: data,
                options: [.documentType:NSAttributedString.DocumentType.html],
                documentAttributes: nil)
            
            resultString = attributedString
            
        }
        catch
        {
            print("Couldn't turn html into attribute string.\(error)")
        }
        
        return resultString
        
    }
}
