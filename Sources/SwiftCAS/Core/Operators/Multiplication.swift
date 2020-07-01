//
//  Multiplication.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Multiplication: MultiNodesOperator {
    var symbol = "*"
    var children: [Node] = []
    
    required init() {}
    
    func simplify() -> Node {
        mergeAllChildren()
        
        if children.contains(where: { ($0 as? NumericalValue)?.toDouble() == 0 }) { return 0 }
        children.removeAll(where: { ($0 as? NumericalValue)?.toDouble() == 1 })
        
        return self
    }
}
