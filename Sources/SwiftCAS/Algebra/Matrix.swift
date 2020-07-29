//
//  Matrix.swift
//  
//
//  Created by Quentin Guidée on 29/07/2020.
//

public class Matrix: Node {
    var nodes: [[Node]] = []
    public var sign: Sign { return .Unknown }
    
    public required init(_ nodes: [[Node]]) {
        self.nodes = nodes
    }
    
    public convenience init(_ nodes: [Node]...) {
        self.init(nodes)
    }
    
    public func simplify() -> Node {
        var simplifiedNodes: [[Node]] = nodes
        // Transform simpl.count -> lines/columns
        for i in 0..<simplifiedNodes.count {
            for j in 0..<simplifiedNodes[0].count {
                simplifiedNodes[i][j] = simplifiedNodes[i][j].simplify()
            }
        }
        return Matrix(simplifiedNodes)
    }
    
    public func toString() -> String {
        var string: String = "["
        nodes.forEach { lines in
            string.append("[")
            lines.forEach { element in
                string.append("\(element.toString()),")
            }
            string.removeLast()
            string.append("],")
        }
        string.removeLast()
        string.append("]")
        return string
    }
    
    public func toLaTeX() -> String {
        // TODO: Implement this
        return "NOT IMPLEMENTED"
    }
}
