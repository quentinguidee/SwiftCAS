//
//  Multiplication.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Multiplication: MultiNodesOperator {
    var symbol = "*"
    var children: [Node] = []
    
    var sign: Sign {
        var sign: Int = 1
        children.forEach({ sign *= $0.sign.rawValue })
        if let s = Sign(rawValue: sign) {
            return s
        } else {
            return .Unknown
        }
    }
    
    required init() {}
    
    func simplify() -> Node {
        mergeAllChildren()
        simplify(children: &children)
        
        if children.contains(where: { ($0 as? NumericalValue)?.toDouble() == 0 }) { return 0 }
        children.removeAll(where: { ($0 as? NumericalValue)?.toDouble() == 1 })
        
        return self
    }
    
    func differentiate(of unknown: Unknown) -> Node {
        return Differential(of: unknown, self)
    }
    
    func integrate(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}
