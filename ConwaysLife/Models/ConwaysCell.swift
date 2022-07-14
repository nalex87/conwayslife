//
//  ConwaysCell.swift
//  ConwaysLife
//
//  Created by Aleksey Nikolaenko on 14.07.2022.
//

import Foundation

struct ConwaysCell: Codable, Hashable, Identifiable {
    
    enum ConwaysCellStatus: String, Codable {
        case alive, dead, unknown
    }
    
    var id = UUID()
    var isAlive: Bool {
        return status == .alive
    }
    let status: ConwaysCellStatus
}
