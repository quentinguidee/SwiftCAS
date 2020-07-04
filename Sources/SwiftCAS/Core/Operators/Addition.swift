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
        
        // 3+0 = 3
        children.removeAll(where: { ($0 as? NumericalValue)?.toDouble() == 0 })
        
        // 3+2 = 5
        var doubleSum: Double = 0
        children.forEach { child in
            if let child = child as? NumericalValue { doubleSum += child.toDouble() }
        }
        children.removeAll(where: { $0 is NumericalValue })
        if doubleSum != 0 {
            let node: Node = doubleSum.toIntIfPossible()
            children.append(node)
        }
        
        if children.count == 1 { return children[0] }
        if children.count == 0 { return 0 }
        
        return self
    }
    
    func differentiate(of unknown: Unknown) -> Node {
        var nodes: [Node] = []
        children.forEach({ nodes.append($0.differentiate(of: unknown)) })
        return Addition(nodes)
    }
    
    func integrate(of unknown: Unknown) -> Node {
        var nodes: [Node] = []
        children.forEach({ nodes.append($0.integrate(of: unknown)) })
        return Addition(nodes)
    }
}
