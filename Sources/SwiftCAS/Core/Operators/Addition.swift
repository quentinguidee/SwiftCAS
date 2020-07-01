//
//  Addition.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Addition: MultiNodesOperator {
    var symbol = "+"
    var children: [Node] = []
    
    var sign: Sign {
        // TODO: Implement
        return .Positive
    }
    
    required init() {}
    
    func simplify() -> Node {
        mergeAllChildren()
        simplify(children: &children)
        
        children.removeAll(where: { ($0 as? NumericalValue)?.toDouble() == 0 })
        
        return self
    }
    
    func absoluteValue() -> Self {
        // TODO: Implement
        return self
    }
}
