//
//  Operator.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol Operator: Node {
    var nodes: [Node] { get set }
    init()
}

extension Operator {
    init(_ nodes: [Node]) {
        self.init()
        self.nodes = nodes
    }
}
