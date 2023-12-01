//
//  EditElement.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-15.
//

import SwiftUI

struct EditElement: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PrintingProceduresViewModel =
    PrintingProceduresViewModel()
    var partViewModel: PartViewModel = PartViewModel()
    var materialViewModel: MaterialViewModel = MaterialViewModel()
    var solutionViewModel: SolutionViewModel = SolutionViewModel()
    
    var pageIndex: Int
    var passPart: Part?
    var passMaterial: Material?
    var passSolution: Solution?
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    let userDefaults = UserDefaults.standard
    @State var tempArray = [String]()
    
    @State var name = ""
    @State var machine = ""
    @State var material = ""
    @State var cost = 0.0
    @State var ttp = ""
    
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
                Text("Update \(passPart!.name)")
                    .font(.largeTitle)
                List{
                    
                    TextField("Enter a  name", text: $name).validate {
                        !name.isEmpty
                    }
                    Menu{
                        ForEach(tempArray, id: \.self){
                                machine in
                            Button(action: {
                                self.machine = "\(machine)"
                            }, label: {
                                Text("\(machine)")
                            })
                            }
                    } label:{
                        Text("Machines: ")
                    }
                    Text("\(machine)")
                    Menu{
                        ForEach(materialViewModel.materialList){
                                material in
                            Button(action: {
                                self.material = "\(material.name) - \(material.color) | \(material.material)"
                            }, label: {
                                Text("\(material.name)")
                            })
                            }
                    } label:{
                        Text("Materials: ")
                    }
                    Text("\(material)")
                    TextField("Estimated Cost:", value: $cost, formatter: formatter)
                        .validate {
                            cost <= 0
                        }
                    TextField("Total Time to Print:", text: $ttp).validate {
                        !ttp.isEmpty
                    }
                }
                .onAppear(perform: {
                    tempArray = userDefaults.object(forKey: "machines") as? [String] ?? [""]
                    name = passPart!.name
                    machine = passPart!.machine
                    material = passPart!.material
                    cost = passPart!.cost
                    ttp = passPart!.ttp
                })
                Button(action: {
                    partViewModel.partToBeUpdated = passPart!
                    partViewModel.partToBeUpdated.name = name
                    partViewModel.partToBeUpdated.machine = machine
                    partViewModel.partToBeUpdated.material = material
                    partViewModel.partToBeUpdated.cost = cost
                    partViewModel.partToBeUpdated.ttp = ttp
                    
                    partViewModel.updatePart()
                    dismiss()
                }, label: {
                    Label{
                        Text("Update Part")
                    } icon: {
                        
                    }
                    .labelStyle(ElementViewLabel())
                })
                           
            }.toolbar{
                ToolbarItem(placement: .confirmationAction){
                    Button(action: {dismiss()}) {
                        Text("Done")
                    }
                }
            }

            
            
        case 2:
            NavigationStack{
                Text("Update \(passMaterial!.name)")
                    .font(.largeTitle)
                List{
                    
                    TextField("Enter a  name", text: $materialName)
                        .validate {
                            !materialName.isEmpty
                        }
                    TextField("Material:", text: $materialType)
                        .validate {
                            !materialType.isEmpty
                        }
                    TextField("Color:", text: $color).validate {
                        !color.isEmpty
                    }
                    TextField("Cost Per Kilo:", value: $costperkilo, formatter: formatter)
                        .validate {
                            costperkilo <= 0
                        }
                }
                .onAppear(perform: {
                    materialName = passMaterial!.name
                    materialType = passMaterial!.material
                    color = passMaterial!.color
                    costperkilo = passMaterial!.costperkilo
                })
                Button(action: {
                    materialViewModel.materialToBeUpdated = passMaterial!
                    materialViewModel.materialToBeUpdated.name = materialName
                    materialViewModel.materialToBeUpdated.material = materialType
                    materialViewModel.materialToBeUpdated.color = color
                    materialViewModel.materialToBeUpdated.costperkilo = costperkilo
                    
                    materialViewModel.updateMaterial()
                    dismiss()
                }, label: {
                    Label{
                        Text("Update Material")
                    } icon: {
                        
                    }
                    .labelStyle(ElementViewLabel())
                })
                .labelStyle(ElementViewLabel())
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
                    solutionViewModel.solutionToBeUpdated.name = materialName
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
        
        default:
            Text("Error")
            
            
        }
    }
}


struct EditElement_Previews: PreviewProvider {
    static var previews: some View {
        EditElement(pageIndex: 2, passPart: Part(name: "Default Part", machine: "Eleego Mars 2", material: "PLA - White", cost: 0, ttp: "2H 30M"), passMaterial: Material(name: "Default Name", material: "Default Material", color: "White", costperkilo: 32.99), passSolution: Solution(name: "Default Solution", costperlitre: 12.99))
    }
}
