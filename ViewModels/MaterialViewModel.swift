//
//  MaterialViewModel.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-20.
//

import Combine

class MaterialViewModel: ObservableObject {
    
    @Published var materialRepo = MaterialRepository.shared
    @Published var materialList = [Material]()
    @Published var materialToBeUpdated = Material()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.materialRepo.$list
            .assign(to:  \.materialList, on: self)
            .store(in: &cancellables)
        
        for material in self.materialList{
            print("Material: \(material.name)")
        }
    }
    
    func addMaterial(material: Material) {
        materialRepo.add(material)
    }
    
    func updateMaterial(){
        materialRepo.update(materialToBeUpdated)
    }
    
    func deleteMaterial(material: Material){
        materialRepo.delete(material)
    }
}

