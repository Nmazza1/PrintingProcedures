//
//  Solution.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-16.
//

import Foundation
import FirebaseFirestoreSwift

struct Solution: Identifiable, Codable{
    @DocumentID var id: String?
    var name: String = ""
    var costperlitre: Double = 0.0
   
    init(){
        
    }
    
  
    init(name: String, costperlitre: Double ){
        self.name = name
        self.costperlitre = costperlitre
    }
}
