//
//  SolutionViewModel.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-20.
//

import Combine

class SolutionViewModel: ObservableObject {
    
    @Published var solutionRepo = SolutionRepository.shared
    @Published var solutionList = [Solution]()
    @Published var solutionToBeUpdated = Solution()
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.solutionRepo.$list
            .assign(to:  \.solutionList, on: self)
            .store(in: &cancellables)
        
        for solution in self.solutionList{
            print("Solution: \(solution.name)")
        }
    }
    
    func addSolution(solution: Solution) {
        solutionRepo.add(solution)
    }
    
    func updateSolution(){
        solutionRepo.update(solutionToBeUpdated)
    }
    
    func deleteSolution(solution: Solution){
        solutionRepo.delete(solution)
    }
}

