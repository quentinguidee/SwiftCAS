//
//  Matrix.swift
//  
//
//  Created by Quentin Guidée on 29/07/2020.
//

public class Matrix: Node {
    public private(set) var nodes: [[Node]] = []
    
    public var linesCount: Int { return nodes.count }
    public var columnsCount: Int { return nodes[0].count }
    public var isSquare: Bool { return linesCount == columnsCount }
    
    public var sign: Sign { return .Unknown }
    
    public required init(_ nodes: [[Node]]) {
        self.nodes = nodes
    }
    
    public convenience init(_ nodes: [Node]...) {
        self.init(nodes)
    }
    
    public func determinant() -> Node {
        if (linesCount, columnsCount) == (2, 2) {
            return Addition(
                Multiplication(nodes[0][0], nodes[1][1]),
                Opposite(Multiplication(nodes[0][1], nodes[1][0]))
            ).simplify()
        } else if (linesCount, columnsCount) == (3, 3) {
            return Addition(
                Multiplication(nodes[0][0], nodes[1][1], nodes[2][2]),
                Multiplication(nodes[0][1], nodes[1][2], nodes[2][0]),
                Multiplication(nodes[0][2], nodes[1][0], nodes[2][1]),
                Opposite(Multiplication(nodes[0][2], nodes[1][1], nodes[2][0])),
                Opposite(Multiplication(nodes[0][0], nodes[1][2], nodes[2][1])),
                Opposite(Multiplication(nodes[0][1], nodes[1][0], nodes[2][2]))
            ).simplify()
        }
        return Double.nan
    }
    
    public func trace() -> Node {
        var nodes: [Node] = []
        
        if !isSquare { return Double.nan }
        
        var i = 0
        while i < linesCount {
            nodes.append(self.nodes[i][i])
            i += 1
        }
        return Addition(nodes).simplify()
    }
    
    public func simplify() -> Node {
        var simplifiedLines: [[Node]] = nodes
        for i in 0..<linesCount {
            for j in 0..<columnsCount {
                simplifiedLines[i][j] = simplifiedLines[i][j].simplify()
            }
        }
        return Matrix(simplifiedLines)
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
