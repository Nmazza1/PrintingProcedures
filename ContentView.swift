//
//  ContentView.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-02.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: PrintingProceduresViewModel =
    PrintingProceduresViewModel()
    
    @StateObject var partViewModel = PartViewModel()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Welcome Back")
                    .font(.custom("JetBrainsMono-Regular", size: 30))
                Spacer()
                Text("You currently have \(partViewModel.partList.count) Projects in your backlog")
                    .multilineTextAlignment(.center)
                    .font(.custom("JetBrainsMono-Regular", size: 15))
                Spacer()
                VStack{
                    ScrollView(.vertical){
                        ForEach(partViewModel.partList){
                                part in
                                Collapsible(part: part, collapsed: true)
                            }
                    }
                    Spacer()
                }.padding(10)
                    .frame(maxWidth: .infinity, maxHeight: 350)
                    .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                    .border(.black)
                    .shadow(color: .black.opacity(0.25), radius: 3.5,
                            x: 3, y: 9)
                
                Spacer()
                
                
        
                Spacer()
                
            }
            .padding(50)

            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity
            )
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    NavigationLink(destination: Preferences(), label:
                                    {Image(systemName: "gear.circle")
                            .font(.title)
                    })
                }
                ToolbarItemGroup(placement: .bottomBar){
                    
                    Button(action: {showingSheet.toggle()}, label: {
                        Label{
                            Text("Add Part")
                        } icon: {
                        }
                        .labelStyle(ElementViewLabel())
                    })
                        .sheet(isPresented: $showingSheet){
                            AddPart()
                    }
                }
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
