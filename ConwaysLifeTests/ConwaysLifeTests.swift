//
//  ConwaysLifeTests.swift
//  ConwaysLifeTests
//
//  Created by Aleksey Nikolaenko on 13.07.2022.
//

import XCTest
@testable import ConwaysLife

class ConwaysLifeTests: XCTestCase {

    func testConwaysCellModel() throws {
        let aliveCell = ConwaysCell(status: .alive)
        XCTAssert(aliveCell.isAlive, "Incorrect isAlive value")
        let deadCell = ConwaysCell(status: .dead)
        XCTAssert(deadCell.isAlive == false, "Incorrect isAlive value")
    }

    func testConwaysCellStoreInitializer() throws {
        let cellStore = ConwaysCellStore()
        XCTAssertEqual(cellStore.cells.count, 10, "Incorrect cells number after init")
        XCTAssertEqual(cellStore.cells[0].count, 10, "Incorrect cells number after init")
    }

    func testConwaysCellStoreJSONProcessor() throws {
        let cellStore = ConwaysCellStore()
        let rawSeedData: [[String]] = try cellStore.processJSONData(filename: "seedData.json")
        let cells = [
            ["alive", "alive", "dead", "alive", "dead", "alive", "dead", "alive", "dead", "dead"],
            ["dead", "alive", "dead", "alive", "dead", "alive", "dead", "alive", "dead", "dead"],
            ["dead", "alive", "dead", "alive", "dead", "alive", "dead", "alive", "dead", "dead"],
            ["dead", "alive", "dead", "alive", "dead", "alive", "dead", "dead", "dead", "dead"],
            ["dead", "alive", "dead", "alive", "dead", "alive", "dead", "alive", "dead", "dead"],
            ["dead", "alive", "dead", "alive", "dead", "alive", "dead", "alive", "dead", "dead"],
            ["dead", "alive", "alive", "alive", "dead", "alive", "dead", "alive", "dead", "dead"],
            ["dead", "alive", "dead", "alive", "dead", "alive", "dead", "alive", "dead", "dead"],
            ["dead", "alive", "dead", "alive", "dead", "alive", "dead", "alive", "dead", "dead"],
            ["dead", "alive", "dead", "alive", "dead", "alive", "dead", "alive", "dead", "alive"]
        ]
        XCTAssertEqual(rawSeedData, cells, "Incorrect processed data")
    }
    
    func testConwaysCellStoreNextGeneration() throws {
        let cellStore = ConwaysCellStore()
        XCTAssertEqual(cellStore.cells[0][0].status, ConwaysCell(status: .alive).status, "Incorrect cell data after init")
        XCTAssertEqual(cellStore.cells[1][1].status, ConwaysCell(status: .alive).status, "Incorrect cell data after init")
        cellStore.generateNextGeneration()
        XCTAssertEqual(cellStore.cells[0][0].status, ConwaysCell(status: .alive).status, "Incorrect cell data on the next generation")
        XCTAssertEqual(cellStore.cells[1][1].status, ConwaysCell(status: .dead).status, "Incorrect cell data the next generation")
    }
}
