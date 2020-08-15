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
    
    public var dimension: Dimension { return Dimension(linesCount, columnsCount) }
    public var order: Order { return dimension }
    
    public var isSquare: Bool { return linesCount == columnsCount }
    
    public var sign: Sign { return .Unknown }
    
    public static var rotation: Matrix {
        return Matrix(
            [Cos(Unknown()), Opposite(Sin(Unknown()))],
            [Sin(Unknown()), Cos(Unknown())])
    }
    
    public required init(_ nodes: [[Node]]) {
        self.nodes = nodes
    }
    
    public convenience init(_ nodes: [Node]...) {
        self.init(nodes)
    }
    
    public func shallowCopy() -> Self {
        return Self(nodes)
    }
    
    public static func identity(order: Int) -> Matrix {
        var nodes: [[Node]] = []
        for i in 0..<order {
            var line: [Node] = []
            for j in 0..<order {
                line.append(i == j ? 1 : 0)
            }
            nodes.append(line)
        }
        return Matrix(nodes)
    }
    
    public func determinant() -> Node {
        if (linesCount, columnsCount) == (2, 2) {
            return Addition(
                Multiplication(nodes[0][0], nodes[1][1]),
                Opposite(Multiplication(nodes[0][1], nodes[1][0]))
            ).simplified()
        } else if (linesCount, columnsCount) == (3, 3) {
            return Addition(
                Multiplication(nodes[0][0], nodes[1][1], nodes[2][2]),
                Multiplication(nodes[0][1], nodes[1][2], nodes[2][0]),
                Multiplication(nodes[0][2], nodes[1][0], nodes[2][1]),
                Opposite(Multiplication(nodes[0][2], nodes[1][1], nodes[2][0])),
                Opposite(Multiplication(nodes[0][0], nodes[1][2], nodes[2][1])),
                Opposite(Multiplication(nodes[0][1], nodes[1][0], nodes[2][2]))
            ).simplified()
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
        return Addition(nodes).simplified()
    }
    
    public func transpose() -> Matrix {
        var lines: [[Node]] = []
        for i in 0..<columnsCount {
            var newLine: [Node] = []
            for j in 0..<linesCount {
                newLine.append(nodes[j][i])
            }
            lines.append(newLine)
        }
        return Matrix(lines)
    }
    
    public func simplified() -> Node {
        var simplifiedLines: [[Node]] = []
        for i in 0..<linesCount {
            var simplifiedLine: [Node] = []
            for j in 0..<columnsCount {
                simplifiedLine.append(nodes[i][j].simplified())
            }
            simplifiedLines.append(simplifiedLine)
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

extension Matrix: Equatable {
    public static func == (lhs: Matrix, rhs: Matrix) -> Bool {
        return lhs.nodes.elementsEqual(rhs.nodes, by: { nodesA, nodesB in
            nodesA.elementsEqual(nodesB, by: { nodeA, nodeB in
                nodeA.isEqualTo(nodeB)
            })
        })
    }
}

public typealias Order = Dimension

public struct Dimension {
    var n: Int
    var m: Int
    
    init(_ n: Int, _ m: Int) {
        self.n = n
        self.m = m
    }
}
