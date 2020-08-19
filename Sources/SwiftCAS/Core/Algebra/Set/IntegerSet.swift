//
//  IntegerSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

struct IntegerSet: Set {
    static let symbol: String = "ℤ"
    
    static func contains(_ node: Node) -> Bool {
        if node is Int {
            return true
        }
        return false
    }
}
