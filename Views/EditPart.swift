//
//  EditPart.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-30.
//

import SwiftUI

struct EditPart: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PrintingProceduresViewModel =
    PrintingProceduresViewModel()
    var partViewModel: PartViewModel = PartViewModel()
    var materialViewModel: MaterialViewModel = MaterialViewModel()
    var solutionViewModel: SolutionViewModel = SolutionViewModel()
    
    var passPart: Part?
    
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

    var body: some View {
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

    }
}

struct EditPart_Previews: PreviewProvider {
    static var previews: some View {
        EditPart(passPart: Part(name: "Default Part", machine: "Eleego Mars 2", material: "PLA - White", cost: 0, ttp: "2H 30M"))
    }
}
