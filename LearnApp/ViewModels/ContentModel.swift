//
//  ContentModel.swift
//  LearnApp
//
//  Created by Justin Su on 8/10/21.
//

import Foundation

class ContentModel: ObservableObject {
    
    @Published var modules = [Module]()
    
    var styleData: Data?
    
    init() {
        
        getLocalData()
    }
    
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
    
}
