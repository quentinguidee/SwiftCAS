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
    
    /*
     Rules:
     
     0*x        -> 0
     x*x        -> x^2
     
     x^y * x^z  -> x^(y+z)
     */
    func simplify() -> Node {
        mergeAllChildren()
        
        if children.contains(where: { ($0 as? NumericalValue)?.toDouble() == 0 }) { return 0 }
        
        return self
    }
}
