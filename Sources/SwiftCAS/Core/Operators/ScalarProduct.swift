//
//  ScalarProduct.swift
//  
//
//  Created by Quentin Guidée on 28/07/2020.
//

public typealias DotProduct = ScalarProduct

public class ScalarProduct: Operator {
    var leftNode, rightNode: Node
    public var sign: Sign { return .Unknown }
    
    public required init(_ leftNode: Node, _ rightNode: Node) {
        self.leftNode = leftNode
        self.rightNode = rightNode
    }
    
    public func simplified() -> Node {
        if let leftNode = leftNode as? Vector, let rightNode = rightNode as? Vector {
            if (leftNode.isZero() || rightNode.isZero()) {
                return 0
            }
        }
        
        return ScalarProduct(leftNode, rightNode)
    }
    
    public func toString() -> String {
        return "⟨\(leftNode.toString()),\(rightNode.toString())⟩"
    }
    
    public func toLaTeX() -> String {
        return "\\langle\(leftNode.toLaTeX()),\(rightNode.toLaTeX())\\rangle"
    }
}