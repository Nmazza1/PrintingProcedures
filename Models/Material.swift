//
//  Material.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-16.
//

import Foundation
import FirebaseFirestoreSwift

struct Material: Identifiable, Codable{
    @DocumentID var id: String?
    var name: String = ""
    var material: String = ""
    var color: String = ""
    var costperkilo: Double = 0.0
    
    init(name: String, material: String, color: String, costperkilo: Double ){
        self.name = name
        self.material = material
        self.color = color
        self.costperkilo = costperkilo
    }
    
    init(){
        
    }
}
