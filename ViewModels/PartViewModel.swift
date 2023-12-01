//
//  PartViewModel.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-15.
//

import Combine

class PartViewModel: ObservableObject {
    
    @Published var partRepo = PartRepository.shared
    @Published var partList = [Part]()
    @Published var partToBeUpdated = Part()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.partRepo.$list
            .assign(to:  \.partList, on: self)
            .store(in: &cancellables)
        
        for part in self.partList{
            print("Part: \(part.name)")
        }
    }
    
    func addPart(part: Part) {
        partRepo.add(part)
    }
    
    func updatePart(){
        partRepo.update(partToBeUpdated)
    }
    
    func deletePart(part: Part){
        partRepo.delete(part)
    }
}
