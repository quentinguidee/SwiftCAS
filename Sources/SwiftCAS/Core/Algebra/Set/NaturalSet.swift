//
//  NaturalSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

struct NaturalSet: Set {
    static let symbol: String = "ℕ"
    
    static func contains(_ node: Node) -> Bool {
        if let node = node as? Int, node.isNatural() {
            return true
        }
        return false
    }
}
