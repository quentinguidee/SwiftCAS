//
//  ComplexSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

struct ComplexSet: Set {
    static let symbol: String = "ℕ"
    
    static func contains(_ node: Node) -> Bool {
        if node is Complex || RealSet.contains(node) {
            return true
        }
        return false
    }
}
