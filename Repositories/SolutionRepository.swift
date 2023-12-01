import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class SolutionRepository: ObservableObject {
    static var shared = SolutionRepository()
    
    @Published var list: [Solution] = []
    
    private let path="solutions"
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
                try? $0.data(as: Solution.self)
            } ?? []
        }
    }
    
    func add(_ solution: Solution) {
        
        do{
            _ = try store.collection(path).addDocument(from: solution)
        }
        catch{
            fatalError("Adding a Solution failed")
        }
    }
    
    func update(_ solution: Solution) {
        if let documentId = solution.id {
            store.collection(path).document(documentId).setData(["name": solution.name, "costperlitre" : solution.costperlitre], merge: true) {
                error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func delete(_ solution: Solution){
        if let documentId = solution.id {
            store.collection(path).document(documentId).delete {
                error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
