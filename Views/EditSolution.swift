//
//  EditSolution.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-30.
//

import SwiftUI

struct EditSolution: View {
    @Environment(\.dismiss) var dismiss
    var solutionViewModel: SolutionViewModel = SolutionViewModel()
    
    var passSolution: Solution?
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    @State var solutionName = ""
    @State var costperlitre = 0.0
    var body: some View {
        NavigationStack{
            Text("Update \(passSolution!.name)")
                .font(.largeTitle)
            List{
                TextField("Enter a name", text: $solutionName).validate {
                    !solutionName.isEmpty
                }
                TextField("Cost per Litre:", value: $costperlitre, formatter: formatter)
                    .validate {
                        costperlitre <= 0
                    }
            }
            .onAppear(perform: {
                solutionName = passSolution!.name
                costperlitre = passSolution!.costperlitre
            })
            Button(action: {
                solutionViewModel.solutionToBeUpdated = passSolution!
                solutionViewModel.solutionToBeUpdated.name = solutionName
                solutionViewModel.solutionToBeUpdated.costperlitre = costperlitre
        
                solutionViewModel.updateSolution()
                dismiss()
            }, label: {
                Label{
                    Text("Update Solution")
                } icon: {
                    
                }
                .labelStyle(ElementViewLabel())
            }).labelStyle(ElementViewLabel())

                            
        }.toolbar{
            ToolbarItem(placement: .confirmationAction){
                Button(action: {dismiss()}) {
                    Text("Done")
                }
            }
        }
    }
}

struct EditSolution_Previews: PreviewProvider {
    static var previews: some View {
        EditSolution(passSolution: Solution(name: "Default Solution", costperlitre: 12.99))
    }
}
