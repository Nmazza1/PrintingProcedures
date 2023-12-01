//
//  AddMachine.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-11-30.
//

import SwiftUI

struct AddMachine: View {
    @Environment(\.dismiss) var dismiss
    
    @State var machineName = ""

    let userDefaults = UserDefaults.standard
    @State var tempArray = [String]()
    @StateObject var solutionViewModel = SolutionViewModel()
    
    let formatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter
        }()
    
    var body: some View {
        NavigationStack{
            Text("Machines")
                .font(.custom("JetBrainsMono-Regular", size: 20))
                TextField("Name of Machine:", text: $machineName).validate {
                    !machineName.isEmpty
                }
            VStack{
                Text("Machines: ")
                List(tempArray, id: \.self){
                            machine in
                    Text("\(machine)").onLongPressGesture{
                        tempArray = tempArray.filter{
                            $0 != "\(machine)"
                        }
                        userDefaults.set(tempArray, forKey: "machines")
                    }
                }
            }.onAppear(){
                tempArray = userDefaults.object(forKey: "machines") as? [String] ?? [""]
            }
            Button(action: {
                print("Button pressed")
                tempArray.append("\(machineName)")
                print(tempArray)
                machineName = ""
                userDefaults.set(tempArray, forKey: "machines")
            }, label: {
                Label{
                    Text("Add New Machine")
                        .font(.custom("JetBrainsMono-Regular", size: 20))
                } icon: {
                    
                }
                .labelStyle(ElementViewLabel())
            })
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
struct AddMachine_Previews: PreviewProvider {
    static var previews: some View {
        AddMachine()
    }
}
