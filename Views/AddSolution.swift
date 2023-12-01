//
//  AddSolution.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-30.
//

import SwiftUI

struct AddSolution: View {
    @Environment(\.dismiss) var dismiss
    
    @State var solutionName = ""
    @State var costperlitre = 0.0

    @StateObject var solutionViewModel = SolutionViewModel()
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        NavigationStack{
            Text("Add A Solution")
                .font(.custom("JetBrainsMono-Regular", size: 20))
            List{
                TextField("Enter a  name", text: $solutionName).validate {
                    !solutionName.isEmpty
                }
                TextField("Cost per litre:", value: $costperlitre, formatter: formatter)
                    .validate {
                        costperlitre <= 0
                    }
            }
            Button(action: {
                let solution = Solution(name: solutionName, costperlitre: costperlitre)
                print(solution.name)
                print(solution.costperlitre)
                solutionViewModel.addSolution(solution: solution)
                solutionName = ""
                costperlitre = 0.0
            }, label: {
                Label{
                    Text("Add New Solution")
                        .font(.custom("JetBrainsMono-Regular", size: 20))
                } icon: {
                    
                }
                .labelStyle(ElementViewLabel())
            })
            .toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button(action: {dismiss()}) {
                        Text("Done")
                            .font(.custom("JetBrainsMono-Regular", size: 20))
                    }
                }
            }
        }
    }
}

struct AddSolution_Previews: PreviewProvider {
    static var previews: some View {
        AddSolution()
    }
}
