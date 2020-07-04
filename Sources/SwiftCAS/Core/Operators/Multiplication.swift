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
        
        // x*0 = 0
        if children.contains(where: { ($0 as? NumericalValue)?.toDouble() == 0 }) { return 0 }
        
        // x*1 = x
        children.removeAll(where: { ($0 as? NumericalValue)?.toDouble() == 1 })
        
        // 3*2 = 6
        var doubleMultiplication: Double = 1
        children.forEach { child in
            if let child = child as? NumericalValue { doubleMultiplication *= child.toDouble() }
        }
        children.removeAll(where: { $0 is NumericalValue })
        if doubleMultiplication != 1 {
            let node: Node = doubleMultiplication.toIntIfPossible()
            children.append(node)
        }
        
        if children.count == 1 { return children[0] }
        if children.count == 0 { return 0 }
        
        return self
    }
    
    func differentiate(of unknown: Unknown) -> Node {
        return Differential(of: unknown, self)
    }
    
    func integrate(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}
