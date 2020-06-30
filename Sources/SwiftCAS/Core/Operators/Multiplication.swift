//
//  Multiplication.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Multiplication: MultiNodesOperator {
    var symbol = "*"
    var minNumberOfChildren: Int = 2
    var maxNumberOfChildren: Int = Int.max
    var children: [Node] = []
    
    required init() {}
    
    /*
     Rules:
     
     0*x        -> 0
     x*0        -> 0
     x*x        -> x^2
     
     x^y * x^z  -> x^(y+z)
     */
    func simplify() -> Node { return self }
}
