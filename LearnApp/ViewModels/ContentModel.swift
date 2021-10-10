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
    
    // current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    var styleData: Data?
    
    init() {
        
        getLocalData()
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
    
    func hasNextLesson() -> Bool {
        
        if currentLessonIndex+1 < currentModule!.content.lessons.count {
            return true
        }
        
        return false
    }
}
