//
//  Multiplication.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public func *(lhs: Node, rhs: Node) -> Node { return Multiplication(lhs, rhs) }

public typealias Mult = Multiplication

public class Multiplication: MultiNodesOperator {
    public private(set) var symbol = "*"
    public var children: [Node] = []
    
    public var sign: Sign {
        var sign: Int = 1
        children.forEach({ sign *= $0.sign.rawValue })
        if let s = Sign(rawValue: sign) {
            return s
        } else {
            return .Unknown
        }
    }
    
    public required init() {}
    
    public func simplified() -> Node {
        let simplified = Multiplication(children)
        simplified.mergeAllChildren()
        simplify(children: &simplified.children)
        
        // x*0 = 0
        if simplified.children.contains(where: { ($0 as? NumericalValue)?.toDouble() == 0 }) { return 0 }
        
        // x*1 = x
        simplified.children.removeAll(where: { ($0 as? NumericalValue)?.toDouble() == 1 })
        
        // 3*2 = 6
        var doubleMultiplication: Double = 1
        simplified.children.forEach { child in
            if let child = child as? NumericalValue { doubleMultiplication *= child.toDouble() }
        }
        simplified.children.removeAll(where: { $0 is NumericalValue })
        if doubleMultiplication != 1 {
            let node: Node = doubleMultiplication.toIntIfPossible()
            simplified.children.append(node)
        }
        
        if simplified.children.count == 1 { return simplified.children[0] }
        if simplified.children.count == 0 { return 0 }
        
        return simplified
    }
}
