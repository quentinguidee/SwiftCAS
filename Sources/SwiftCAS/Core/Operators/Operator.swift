//
//  Operator.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol Operator: Node {
    func simplify() -> Node
}

extension Operator {
    func simplify(node: inout Node) {
        if node is Operator {
            node = (node as! Operator).simplify()
        }
    }
}
