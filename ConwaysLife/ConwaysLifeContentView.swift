//
//  ConwaysLifeContentView.swift
//  ConwaysLife
//
//  Created by Aleksey Nikolaenko on 13.07.2022.
//

import SwiftUI
import Combine

struct ConwaysLifeContentView: View {
    
    @ObservedObject
    var cellStore: ConwaysCellStore

    let columns = Array(repeating: GridItem(.flexible(minimum: 1, maximum: 100)), count: gridSize)
    
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 120.0, height: 100.0)
            Text("Conway’s Game of Life")
                .padding(.bottom)
            
            Spacer()
            
            ScrollView {
                LazyVGrid(columns: columns, alignment: .center, spacing: 0) {
                    ForEach(0..<cellStore.cells.endIndex) { rowIndex in
                        ForEach(cellStore.cells[rowIndex], id: \.id) { cell in
                            Image(cell.status.rawValue)
                                .resizable()
                                .frame(width: 30, height: 25.0)
                        }
                    }
                    
                }
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            }
            
            Spacer()

            Button("Next generation") {
                cellStore.generateNextGeneration()
            }
            .padding(.vertical)
        }
    }
}


struct ConwaysLifeContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConwaysLifeContentView(cellStore: ConwaysCellStore())
        }
    }
}
