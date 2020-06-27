//
//  Multiplication.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Multiplication: MultiNodesOperator {
    var symbol = "*"
    var minOfNodes: Int = 2
    var maxOfNodes: Int = Int.max
    var nodes: [Node] = []
    
    required init() {}
}
