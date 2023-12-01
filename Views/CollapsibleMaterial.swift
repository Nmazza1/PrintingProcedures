//
//  CollapsibleMaterial.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-16.
//

import SwiftUI

struct CollapsibleMaterial: View {
    var material: Material
    @State var collapsed: Bool = true
    @StateObject var materialViewModel = MaterialViewModel()
    
    var body: some View {
        VStack {
            Button(
                action: { collapsed.toggle() },
                label: {
                        VStack{
                            if(collapsed){
                                Text("\(material.name) - \(material.color)")
                                    .padding()
                                    .font(.custom("JetBrainsMono-Regular", size: 15))
                                    .foregroundColor(.white)
                                
                            }
                            if(!collapsed)
                            {
                                Text(material.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                
                                Text("\(material.material)\n \(material.color)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                Text("\(material.costperkilo)$ / Kg")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                HStack{
                                    Spacer()
                                    NavigationLink(destination: EditElement(pageIndex: 2, passMaterial: material), label:
                                                    {Image(systemName: "pencil")
                                            .foregroundColor(.white)
                                    })
                                    Button(action: {
                                        materialViewModel.deleteMaterial(material: material)
                                    }, label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.white)
                                    })
                                    .buttonStyle(BorderlessButtonStyle())
                                }
                            }
                        }
                        .frame(width: 300)
                        .background(Color(.systemGray))
                        .shadow(color: .black.opacity(0.25), radius: 3.5,
                                x: 3, y: 9)
                        .border(.black)
                    
                }
            )
            .buttonStyle(PlainButtonStyle())
            .clipped()
            .animation(.linear, value: 5.0)
            
        }
    }
}

struct CollapsibleMaterial_Previews: PreviewProvider {
    static var previews: some View {
        CollapsibleMaterial(material: Material(name: "Default Name", material: "Default Material", color: "Default Color", costperkilo: 39.99))
    }
}
