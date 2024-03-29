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
    
    public func shallowCopy() -> Self {
        return Self(children)
    }
    
    public func simplified() -> Node {
        let simplified = shallowCopy()
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
    
    public func prettified() -> Node {
        return shallowCopy()
    }
}

extension Addition: Integrable {
    public func integrated(of unknown: Unknown) -> Node {
        var nodes: [Node] = []
        children.forEach({ nodes.append($0.integrated(of: unknown)) })
        return Addition(nodes)
    }
}

extension Addition: Differentiable {
    public func differentiated(of unknown: Unknown) -> Node {
        var nodes: [Node] = []
        children.forEach({ nodes.append($0.differentiated(of: unknown)) })
        return Addition(nodes)
    }
}

extension Addition: Equatable {
    public static func == (lhs: Addition, rhs: Addition) -> Bool {
        guard lhs.children.count == rhs.children.count else { return false }
        
        let lhsChildren = lhs.children
        var rhsChildren = rhs.children
        
        for node in lhsChildren {
            let i = rhsChildren.firstIndex(where: { $0.isEqualTo(node)}) ?? -1
            if i != -1 { rhsChildren.remove(at: i) }
        }
        
        return rhsChildren.isEmpty
    }
}
