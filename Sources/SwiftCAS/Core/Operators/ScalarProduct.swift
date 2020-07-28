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
    
    public func simplify() -> Node {
        return self
    }
    
    public func toString() -> String {
        return "⟨\(leftNode.toString()),\(rightNode.toString())⟩"
    }
    
    public func toLaTeX() -> String {
        return "\\langle\(leftNode.toLaTeX()),\(rightNode.toLaTeX())\\rangle"
    }
}
