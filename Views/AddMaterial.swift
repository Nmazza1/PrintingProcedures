//
//  AddMaterial.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-30.
//

import SwiftUI

struct AddMaterial: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var materialViewModel = MaterialViewModel()
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    @State var materialName = ""
    @State var materialType = ""
    @State var color = ""
    @State var costperkilo = 0.0
    
    var disableMaterial: Bool {
        materialName.count <= 0 || materialType.count <= 0 || color.count <= 0
    }
    
    var body: some View {
        NavigationStack{
            Text("Add A Material")
                .font(.custom("JetBrainsMono-Regular", size: 20))
            List{
                TextField("Enter a  name", text: $materialName)
                    .validate {
                        !materialName.isEmpty
                    }
                    TextField("Material Color:", text: $color)
                        .validate {
                            !color.isEmpty
                        }
                        TextField("Material Type:", text: $materialType)
                            .validate {
                                !materialType.isEmpty
                            }
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
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                            } icon: {
                                
                            }
                            .labelStyle(ElementViewLabel())
                        }).disabled(disableMaterial)
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
struct AddMaterial_Previews: PreviewProvider {
    static var previews: some View {
        AddMaterial()
    }
}
