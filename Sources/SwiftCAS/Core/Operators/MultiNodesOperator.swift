//
//  MultiNodesOperator.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol MultiNodesOperator: Operator {
    var separatorSymbol: String { get set }
}

extension MultiNodesOperator {
    func toString() -> String {
        var s: String = ""
        nodes.forEach { s += $0.toString() + separatorSymbol }
        return String(s.dropLast())
    }
    
    func toLaTeX() -> String {
        return toString()
    }
}
