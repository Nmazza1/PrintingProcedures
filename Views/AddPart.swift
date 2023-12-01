//
//  AddPart.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-30.
//

import SwiftUI

struct AddPart: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: PrintingProceduresViewModel =
    PrintingProceduresViewModel()
    
    @StateObject var partViewModel = PartViewModel()
    @StateObject var materialViewModel = MaterialViewModel()
    @StateObject var solutionViewModel = SolutionViewModel()
    
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
    
    let userDefaults = UserDefaults.standard
    @State var tempArray = [String]()
    
    var disablePart: Bool {
        name.count <= 0 || machine.count <= 0 || material.count <= 0 || ttp.count <= 0
    }
    
    var body: some View {
        NavigationStack{
            Text("Add A Part")
                .font(.custom("JetBrainsMono-Regular", size: 20))
            List{
                TextFormView { validate in
                    VStack{
                        TextField("Enter a  name", text: $name)
                            .validate {
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
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Total Time to Print:", text: $ttp)
                            .validate {
                                !ttp.isEmpty
                            }
                    }.onAppear(){
                        tempArray = userDefaults.object(forKey: "machines") as? [String] ?? [""]
                    }
                }
            }
            
            Button(action: {
                let part = Part(name: name, machine: machine,
                                material: material, cost: cost, ttp: ttp )
                partViewModel.addPart(part: part)
                name = ""
                machine = ""
                material = ""
                cost = 0.0
                ttp = ""
            }, label: {
                Label{
                    Text("Add New Part").font(.custom("JetBrainsMono-Regular", size: 20))
                } icon: {
                    
                }
                .labelStyle(ElementViewLabel())
            }).disabled(disablePart)
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

struct AddPart_Previews: PreviewProvider {
    static var previews: some View {
        AddPart()
    }
}
