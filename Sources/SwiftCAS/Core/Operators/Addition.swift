//
//  Addition.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Addition: Operator {
    var nodes: [Node] = []
    
    required init() {}
    
    func toString() -> String {
        var s: String = ""
        nodes.forEach { s += $0.toString() + "+" }
        return String(s.dropLast())
    }
    
    func toLaTeX() -> String {
        return toString()
    }
}
