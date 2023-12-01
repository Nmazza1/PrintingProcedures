import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MaterialRepository: ObservableObject {
    static var shared = MaterialRepository()
    
    @Published var list: [Material] = []
    
    private let path="materials"
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
                try? $0.data(as: Material.self)
            } ?? []
        }
    }
    
    func add(_ material: Material) {
        
        do{
            _ = try store.collection(path).addDocument(from: material)
        }
        catch{
            fatalError("Adding a material failed")
        }
    }
    
    func update(_ material: Material) {
        if let documentId = material.id {
            store.collection(path).document(documentId).setData(["name": material.name, "material": material.material,
                                                                 "color": material.color, "costperkilo" : material.costperkilo], merge: true) {
                error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func delete(_ material: Material){
        if let documentId = material.id {
            store.collection(path).document(documentId).delete {
                error in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
