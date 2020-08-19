//
//  RealSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

struct RealSet: Set {
    static var symbol: String = "ℝ"
    
    static func contains(_ node: Node) -> Bool {
        if node is Double || IntegerSet.contains(node) {
            return true
        }
        return false
    }
}
