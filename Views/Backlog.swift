//
//  Backlog.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-16.
//

import SwiftUI

struct Backlog: View {
    @State private var showingSheet = false
    @StateObject var viewModel: PrintingProceduresViewModel =
    PrintingProceduresViewModel()
    @StateObject var backlogPartViewModel = PartViewModel()
    
    var body: some View {
        NavigationStack{
            
                VStack{
                    Text("Your Backlog")
                        .font(.largeTitle)
                    Text("You have \(backlogPartViewModel.partList.count) Projects awaiting printing")
                    VStack{
                        ScrollView(.vertical){
                            ForEach(backlogPartViewModel.partList){
                                    part in
                                    Collapsible(part: part, collapsed: true)
                                }
                        }
                        Spacer()
                    }.padding(10)
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .background(Color(red: 0.85, green: 0.85, blue: 0.85))
                        .border(.black)
                        .shadow(color: .black.opacity(0.25), radius: 3.5,
                                x: 3, y: 9)
                }
                .padding(50)
                .toolbar{
                    ToolbarItemGroup(placement: .bottomBar){
                        
                        Button(action: {showingSheet.toggle()}, label: {Text("Add Part")})
                            .sheet(isPresented: $showingSheet){
                                AddPart()
                        }
                    }
                }
            
            
        }
    }
}

struct Backlog_Previews: PreviewProvider {
    static var previews: some View {
        Backlog()
    }
}
