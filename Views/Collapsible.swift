//
//  Collapsable.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-12.
//

import SwiftUI

struct Collapsible: View {
    var part: Part
    @State var collapsed: Bool = true
    @StateObject var partViewModel = PartViewModel()
    
    var body: some View {
        VStack {
            Button(
                action: { collapsed.toggle() },
                label: {
                        VStack{
                            if(collapsed){
                                Text(part.name)
                                    .padding()
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                            if(!collapsed)
                            {
                                Text(part.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                
                                Text(part.machine)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                Text(part.material)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                Text("\(part.cost)$")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                Text(part.ttp)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                HStack{
                                   
                                    Spacer()
                                    NavigationLink(destination: EditElement(pageIndex: 1, passPart: part), label:
                                                    {Image(systemName: "pencil")
                                            .foregroundColor(.white)
                                    })
                                    Button(action: {
                                        partViewModel.deletePart(part: part)
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

struct Collapsible_Previews: PreviewProvider {
    static var previews: some View {
        Collapsible(part: Part(name: "Default Part", machine: "Eleego Mars 2", material: "PLA - White", cost: 2.93, ttp: "2H 30M"))
    }
}
