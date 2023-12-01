//
//  EditMaterial.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-30.
//

import SwiftUI

struct EditMaterial: View {
    @Environment(\.dismiss) var dismiss

    var materialViewModel: MaterialViewModel = MaterialViewModel()
    
    var passMaterial: Material?

    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()

    @State var materialName = ""
    @State var materialType = ""
    @State var color = ""
    @State var costperkilo = 0.0
    

    var body: some View {
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
    }
}

struct EditMaterial_Previews: PreviewProvider {
    static var previews: some View {
        EditMaterial(passMaterial: Material(name: "Default Name", material: "Default Material", color: "White", costperkilo: 32.99))
    }
}
