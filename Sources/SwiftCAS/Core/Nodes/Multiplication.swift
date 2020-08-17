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
    public var neutral: Int = 1
    
    public var sign: Sign {
        var sign: Int = 1
        children.forEach { sign *= $0.sign.rawValue }
        if let s = Sign(rawValue: sign) {
            return s
        } else {
            return .Unknown
        }
    }
    
    public required init() {}
    
    public func shallowCopy() -> Self {
        return Self(children)
    }
    
    public func simplified() -> Node {
        let simplified = shallowCopy()
        simplified.mergeAllChildren()
        simplify(children: &simplified.children)
        simplified.mergeAllChildren()
        
        // x*0 = 0
        if simplified.children.contains(where: { ($0 as? NumericalValue)?.toDouble() == 0 }) { return 0 }
        
        simplified.removeAllNeutrals()
        
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
        
        simplified.sortChildren()
        
        return simplified
    }
    
    public func prettified() -> Node {
        let copy = shallowCopy()
        copy.sortChildren()
        return copy
    }
    
    var sortingOrder: [Any] = [NumericalValue.self, SymbolicValue.self, Node.self]
    
    public func sortChildren() {
        children.sort(by: { areInIncreasingOrder($0, $1) })
    }
    
    func areInIncreasingOrder(_ a: Node, _ b: Node) -> Bool {
        let sortID = (a: getSortID(of: a), b: getSortID(of: b))
        if sortID.a == sortID.b, let a = a as? SymbolicValue, let b = b as? SymbolicValue {
            return a.symbol < b.symbol
        }
        return sortID.a < sortID.b
    }
    
    func getSortID(of node: Node) -> Int {
        switch node {
            case is NumericalValue:
                return 0
            case is SymbolicValue:
                return 1
            default:
                return 2
        }
    }
}

extension Multiplication: Equatable {
    public static func == (lhs: Multiplication, rhs: Multiplication) -> Bool {
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
