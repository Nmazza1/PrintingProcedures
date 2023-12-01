//
//  AddElement.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-16.
//

import SwiftUI

struct AddElement: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PrintingProceduresViewModel =
    PrintingProceduresViewModel()
    
    @StateObject var partViewModel = PartViewModel()
    @StateObject var materialViewModel = MaterialViewModel()
    @StateObject var solutionViewModel = SolutionViewModel()
    
    var pageIndex: Int

    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    @State var name = ""
    @State var machine = ""
    @State var material = ""
    @State var cost = 0.0
    @State var ttp = ""
    
    var disablePart: Bool {
        name.count <= 0 || machine.count <= 0 || material.count <= 0 || ttp.count <= 0
    }
    
    @State var materialName = ""
    @State var materialType = ""
    @State var color = ""
    @State var costperkilo = 0.0
    
    @State var solutionName = ""
    @State var costperlitre = 0.0
    var body: some View {
        switch pageIndex{
        case 1:
            NavigationStack{
                
            }
        case 2:
            NavigationStack{
                Text("Add A Material")
                    .font(.largeTitle)
                List{
                    TextField("Enter a  name", text: $materialName)
                    TextField("Material Color:", text: $color)
                    TextField("Material Type:", text: $materialType)
                    TextField("Cost per kilo:", value: $costperkilo, formatter: formatter)
                        .validate {
                            costperkilo <= 0
                        }
                }
                Button(action: {
                    let material = Material(name: materialName, material: materialType, color: color, costperkilo: costperkilo)
                    
                    materialViewModel.addMaterial(material: material)
                    materialName = ""
                    color = ""
                    materialType = ""
                    costperkilo = 0.0
                }, label: {
                    Label{
                        Text("Add New Material")
                    } icon: {
                        
                    }
                    .labelStyle(ElementViewLabel())
                })
                .toolbar{
                    ToolbarItem(placement: .confirmationAction){
                        Button(action: {dismiss()}) {
                            Text("Done")
                        }
                    }
                }
            }
        case 3:
            NavigationStack{
                Text("Add A Solution")
                    .font(.largeTitle)
                List{
                    TextField("Enter a  name", text: $solutionName)
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
                    } icon: {
                        
                    }
                    .labelStyle(ElementViewLabel())
                })
                .toolbar{
                    ToolbarItem(placement: .confirmationAction){
                        Button(action: {dismiss()}) {
                            Text("Done")
                        }
                    }
                }
            }
        
        default:
            Text("Error")
            
            
        }
    }
}

struct AddElement_Previews: PreviewProvider {
    static var previews: some View {
        AddElement(pageIndex: 3)
    }
}
