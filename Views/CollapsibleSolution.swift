//
//  CollapsibleSolution.swift
//  PrintingProcedures
//
//  Created by Nicholas Mazza on 2023-10-16.
//

import SwiftUI

struct CollapsibleSolution: View {
    var solution: Solution
    @State var collapsed: Bool = true
    @StateObject var solutionViewModel = SolutionViewModel()
    
    var body: some View {
        VStack {
            Button(
                action: { collapsed.toggle() },
                label: {
                        VStack{
                            if(collapsed){
                                Text("\(solution.name)")
                                    .padding()
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                            }
                            if(!collapsed)
                            {
                                Text(solution.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                Text("\(solution.costperlitre)$ / Kg")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(5)
                                    .font(.custom("JetBrainsMono-Regular", size: 20))
                                    .foregroundColor(.white)
                                HStack{
                                    Spacer()
                                    NavigationLink(destination: EditElement(pageIndex: 3, passSolution: solution), label:
                                                    {Image(systemName: "pencil")
                                            .foregroundColor(.white)
                                    })
                                    Button(action: {
                                        solutionViewModel.deleteSolution(solution: solution)
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

struct CollapsibleSolution_Previews: PreviewProvider {
    static var previews: some View {
        CollapsibleSolution(solution: Solution(name: "Default Solution", costperlitre: 25.00), collapsed: true)
    }
}
