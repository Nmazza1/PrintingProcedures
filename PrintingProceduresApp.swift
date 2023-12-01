//
//  PrintingProceduresApp.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-02.
//

import SwiftUI
import Firebase

@main
struct PrintingProceduresApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
