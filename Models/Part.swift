//
//  Part.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-05.
//

import Foundation
import FirebaseFirestoreSwift

struct Part: Identifiable,  Codable{
    @DocumentID var id: String?
    var name: String = ""
    var machine: String = ""
    var material: String = ""
    var cost: Double = 0
    var ttp: String = ""
    
    init(){
        
    }
    
    init(name: String, machine: String, material: String, cost: Double, ttp: String){
        self.name = name
        self.machine = machine
        self.material = material
        self.cost = cost
        self.ttp = ttp
    }
    
    
}
