//
//  ConwaysCellStore.swift
//  ConwaysLife
//
//  Created by Aleksey Nikolaenko on 14.07.2022.
//

import Foundation
import Combine

public let gridSize = 10

final class ConwaysCellStore: ObservableObject {

    @Published
    var cells: [[ConwaysCell]] = []
    
    init() {
        guard let rawSeedData: [[String]] = try? processJSONData(filename: "seedData.json") else {
            return
        }
        cells = rawSeedData.map {
            $0.map {
                guard let cellStatus = ConwaysCell.ConwaysCellStatus(rawValue: $0) else {
                    return ConwaysCell(status: .unknown)
                }
                return ConwaysCell(status: cellStatus)
            }
        }
    }
    
    enum ProcessError: Error {
        case fileNotFound(String)
        case fileNotLoaded(String)
        case couldNotProcess(String)
    }
    
    func processJSONData<T: Decodable>(filename: String) throws -> T {
        let data: Data
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw ProcessError.fileNotFound("Couldn't find \(filename) in the bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            throw ProcessError.fileNotLoaded("Couldn't load \(filename) from the bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ProcessError.couldNotProcess("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
    
    func generateNextGeneration() {

        let neighbours = [
            (-1, -1), (0, -1), (1, -1),
            (-1, 0), (1, 0),
            (-1, 1), (0, 1), (1, 1)
        ]

        var nextGenerationCells: [[ConwaysCell]] =
            Array(repeating: Array(repeating: ConwaysCell(status: .unknown), count: gridSize), count: gridSize)
        
        for row in 0..<gridSize {
            for column in 0..<gridSize {
                var neighborsList: [ConwaysCell] = []
                for neighbour in neighbours {
                    if column + neighbour.0 < 0 || column + neighbour.0 >= gridSize ||
                        row + neighbour.1 < 0 || row + neighbour.1 >= gridSize {
                        continue
                    }
                    neighborsList.append(cells[row + neighbour.1][column + neighbour.0])
                }
                
                let liveNeighboursCount = neighborsList.filter {$0.isAlive}.count
                
                let cell = cells[row][column]
                if cell.isAlive && neighborsList.count <= 3 {
                    nextGenerationCells[row][column] = ConwaysCell(status: .alive)
                } else if cell.isAlive == false && liveNeighboursCount == 3 {
                    nextGenerationCells[row][column] = ConwaysCell(status: .alive)
                } else {
                    nextGenerationCells[row][column] = ConwaysCell(status: .dead)
                }
            }
            
        }

        cells = nextGenerationCells
    }
}
