//
//  Vector.swift
//  
//
//  Created by Quentin Guidée on 27/07/2020.
//

public class Vector: Node {
    var nodes: [Node]
    public var sign: Sign { return .Positive }
    
    public required init(_ nodes: Node...) {
        self.nodes = nodes
    }
    
    public func simplify() -> Node {
        for i in 0..<nodes.count {
            nodes[i] = nodes[i].simplify()
        }
        return self
    }
    
    public func toString() -> String {
        var s: String = "("
        nodes.forEach { s += $0.toString() + "," }
        return String(s.dropLast()) + ")"
    }
    
    public func toLaTeX() -> String {
        var s: String = "\\left("
        nodes.forEach { s += $0.toLaTeX() + "," }
        return String(s.dropLast()) + "\\right)"
    }
}