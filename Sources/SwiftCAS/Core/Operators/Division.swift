//
//  Division.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Division: Operator {
    var nodes: [Node] = []
    var minOfNodes: Int = 2
    var maxOfNodes: Int = 2
    
    required init() {}
    
    func toString() -> String {
        return nodes[0].toString() + "/" + nodes[1].toString()
    }
    
    func toLaTeX() -> String {
        return "\\frac{" + nodes[0].toLaTeX() + "}{" + nodes[1].toLaTeX() + "}"
    }
}
