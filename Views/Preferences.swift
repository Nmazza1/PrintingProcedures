//
//  Preferences.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-16.
//

import SwiftUI

struct Preferences: View {
    

    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    Text("Preferences")
                        .font(.custom("JetBrainsMono-Regular", size: 30))
                    NavigationLink(destination: Materials(), label: {RectangleButton(buttonText: "View Materials")
                            .foregroundColor(.black)
                    })
                    NavigationLink(destination: Solutions(), label: {RectangleButton(buttonText: "View Cleaning Solutions")
                            .foregroundColor(.black)
                    })
                    NavigationLink(destination: AddMachine(), label: {RectangleButton(buttonText: "Manage Printers")
                            .foregroundColor(.black)
                    })

                   
                }
                Spacer()
                
            }
            .ignoresSafeArea()
            .padding(50)
            
        }
        
        
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        Preferences()
    }
}
