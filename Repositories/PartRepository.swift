//
//  PartRepository.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-15.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PartRepository: ObservableObject {
    static var shared = PartRepository()
    
    @Published var list: [Part] = []
    
    private let path="parts"
    private let store = Firestore.firestore()
    
    init(){
        get()
    }
    
    func get() {
        store.collection(path).addSnapshotListener {
            snapshot, error in
            
            if let error = error {
                print(error)
                return
            }
            
            self.list = snapshot?.documents.compactMap {
                try? $0.data(as: Part.self)
            } ?? []
        }
    }
    
    func add(_ part: Part) {
        
        do{
            _ = try store.collection(path).addDocument(from: part)
        }
        catch{
            fatalError("Adding a part failed")
        }
    }
    
    func update(_ part: Part) {
        if let documentId = part.id {
            store.collection(path).document(documentId).setData(["name": part.name, "machine": part.machine,
                                                                 "material": part.material, "cost" : part.cost,
                                                                 "ttp" : part.ttp], merge: true) {
                error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func delete(_ part: Part){
        if let documentId = part.id {
            store.collection(path).document(documentId).delete {
                error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
