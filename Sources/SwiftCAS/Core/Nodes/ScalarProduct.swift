//
//  ScalarProduct.swift
//  
//
//  Created by Quentin Guidée on 28/07/2020.
//

public typealias DotProduct = ScalarProduct

public class ScalarProduct: Node {
    public private(set) var leftNode, rightNode: Node
    public var sign: Sign { return .Unknown }
    
    public required init(_ leftNode: Node, _ rightNode: Node) {
        self.leftNode = leftNode
        self.rightNode = rightNode
    }
    
    public func shallowCopy() -> Self {
        return Self(leftNode, rightNode)
    }
    
    public func simplified() -> Node {
        if let leftNode = leftNode as? Vector, let rightNode = rightNode as? Vector {
            if (leftNode.isZero() || rightNode.isZero()) {
                return 0
            }
        }
        
        return shallowCopy()
    }
    
    public func prettified() -> Node {
        return ScalarProduct(leftNode.prettified(), rightNode.prettified())
    }
    
    public func toString() -> String {
        return "⟨\(leftNode.toString()),\(rightNode.toString())⟩"
    }
    
    public func toLaTeX() -> String {
        return "\\langle\(leftNode.toLaTeX()),\(rightNode.toLaTeX())\\rangle"
    }
}

extension ScalarProduct: Equatable {
    public static func == (lhs: ScalarProduct, rhs: ScalarProduct) -> Bool {
        if lhs.leftNode.isEqualTo(rhs.leftNode) && lhs.rightNode.isEqualTo(rhs.rightNode) {
            return true
        }
        // Property: ⟨x,y⟩ = ⟨y,x⟩
        if lhs.leftNode.isEqualTo(rhs.rightNode) && lhs.rightNode.isEqualTo(rhs.leftNode) {
            return true
        }
        // TODO: With Complex: ⟨x,y⟩ = ⟨y,x⟩.conjuguate
        return false
    }
}
