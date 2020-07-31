//
//  Addition.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public func +(lhs: Node, rhs: Node) -> Node { return Addition(lhs, rhs) }
public func -(lhs: Node, rhs: Node) -> Node { return Addition(lhs, Opposite(rhs)) }

public typealias Add = Addition

public class Addition: MultiNodesOperator {
    public private(set) var symbol = "+"
    public var children: [Node] = []
    public var neutral: Int = 0
    
    public var sign: Sign {
        // TODO: Implement
        return .Positive
    }
    
    public required init() {}
    
    public func shallowCopy() -> Node {
        return Addition(children)
    }
    
    public func simplified() -> Node {
        let simplified = shallowCopy() as! Addition
        simplified.mergeAllChildren()
        simplify(children: &simplified.children)
        
        simplified.removeAllNeutrals()
        
        // 3+2 = 5
        var doubleSum: Double = 0
        simplified.children.forEach { child in
            if let child = child as? NumericalValue { doubleSum += child.toDouble() }
        }
        simplified.children.removeAll(where: { $0 is NumericalValue })
        if doubleSum != 0 {
            let node: Node = doubleSum.toIntIfPossible()
            simplified.children.append(node)
        }
        
        if simplified.children.count == 1 { return simplified.children[0] }
        if simplified.children.count == 0 { return 0 }
        
        return simplified
    }
}
