//
//  Materials.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-16.
//

import SwiftUI

struct Materials: View {
    @StateObject var viewModel: PrintingProceduresViewModel =
    PrintingProceduresViewModel()
    @StateObject var materialViewModel = MaterialViewModel()
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Text("Current Materials")
                        .font(.custom("JetBrainsMono-Regular", size: 20))
                    VStack{
                        ScrollView(.vertical){
                            VStack(spacing: 20){
                                ForEach(materialViewModel.materialList){ material in
                                    CollapsibleMaterial(material: material, collapsed: true)
                                }
                            }
                        }
                        Spacer()
                    }.padding(10)
                        .frame(maxWidth: .infinity, maxHeight: 650)
                        .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .border(.black)
                        .shadow(color: .black.opacity(0.25), radius: 3.5,
                                x: 3, y: 9)
                }
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar){
                        
                        NavigationLink(destination: AddMaterial(), label: {Text("Add A Material")})
                            .font(.custom("JetBrainsMono-Regular", size: 25))
                    }
                }
                
            }
            .ignoresSafeArea()
            .padding(50)
           
            
        }
    }
}

struct Materials_Previews: PreviewProvider {
    static var previews: some View {
        Materials()
    }
}
