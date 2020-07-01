//
//  Addition.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Addition: MultiNodesOperator {
    var symbol = "+"
    var children: [Node] = []
    
    required init() {}
    
    /*
     Rules:
     
     0+x -> x
     x-x -> 0
     */
    func simplify() -> Node {
        mergeAllChildren()
        
        children.removeAll(where: { ($0 as? NumericalValue)?.toDouble() == 0 })
        
        return self
    }
}
