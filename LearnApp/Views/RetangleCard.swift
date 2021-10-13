//
//  RetangleCard.swift
//  LearnApp
//
//  Created by Justin Su on 14/10/21.
//

import SwiftUI

struct RetangleCard: View {
    
    var color = Color.white
    
    var body: some View {

        Rectangle()
            .foregroundColor(color)
            .cornerRadius(10)
            .shadow(radius: 5)
        
    }
}

struct RetangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RetangleCard()
    }
}
