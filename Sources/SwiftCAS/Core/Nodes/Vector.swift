//
//  Vector.swift
//  
//
//  Created by Quentin Guidée on 27/07/2020.
//

public class Vector: Node {
    var nodes: [Node]
    public var sign: Sign { return .Positive }
    public var dimension: Int { return nodes.count }
    
    public required init(_ nodes: [Node]) {
        self.nodes = nodes
    }
    
    public convenience init(_ nodes: Node...) {
        self.init(nodes)
    }
    
    public static func zero(dim: Int) -> Vector {
        return Vector(Array<Int>.init(repeating: 0, count: dim))
    }
    
    public func isZero() -> Bool {
        return nodes.allSatisfy { node in
            node.sign == .Signless
        }
    }
    
    public func shallowCopy() -> Self {
        return Self(nodes)
    }
    
    public func simplified() -> Node {
        var simplifiedNodes: [Node] = []
        for i in nodes.indices {
            simplifiedNodes.append(nodes[i].simplified())
        }
        return Vector(simplifiedNodes)
    }
    
    public func prettified() -> Node {
        var prettifiedNodes: [Node] = []
        for i in nodes.indices {
            prettifiedNodes.append(nodes[i].prettified())
        }
        return Vector(prettifiedNodes)
    }
    
    public func toString() -> String {
        var s: String
        s = nodes.map({ $0.toString() }).joined(separator: ",")
        return "(\(s))"
    }
    
    public func toLaTeX() -> String {
        var s: String
        s = nodes.map({ $0.toLaTeX() }).joined(separator: ",")
        return "\\left(\(s)\\right)"
    }
}

extension Vector: Equatable {
    public static func == (lhs: Vector, rhs: Vector) -> Bool {
        guard lhs.nodes.count == rhs.nodes.count else { return false }
        
        for i in lhs.nodes.indices {
            if !lhs.nodes[i].isEqualTo(rhs.nodes[i]) { return false }
        }
        
        return true
    }
}
