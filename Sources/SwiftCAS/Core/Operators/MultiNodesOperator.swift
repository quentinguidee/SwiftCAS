//
//  MultiNodesOperator.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol MultiNodesOperator: Operator {
    var symbol: String { get set }
}

extension MultiNodesOperator {
    func toString() -> String {
        var s: String = ""
        children.forEach { s += $0.toString() + symbol }
        return String(s.dropLast())
    }
    
    func toLaTeX() -> String {
        var s: String = ""
        children.forEach { s += $0.toLaTeX() + symbol }
        return String(s.dropLast())
    }
}
