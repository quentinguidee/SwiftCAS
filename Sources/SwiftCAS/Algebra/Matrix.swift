//
//  Matrix.swift
//  
//
//  Created by Quentin Guidée on 29/07/2020.
//

public class Matrix: Node {
    public private(set) var lines: [[Node]] = []
    
    public var linesCount: Int { return lines.count }
    public var columnsCount: Int { return lines[0].count }
    
    public var sign: Sign { return .Unknown }
    public var determinant: Node {
        if (linesCount, columnsCount) == (2, 2) {
            return Addition(
                Multiplication(lines[0][0], lines[1][1]),
                Opposite(Multiplication(lines[0][1], lines[1][0]))
            ).simplify()
        } else if (linesCount, columnsCount) == (3, 3) {
            return Addition(
                Multiplication(lines[0][0], lines[1][1], lines[2][2]),
                Multiplication(lines[0][1], lines[1][2], lines[2][0]),
                Multiplication(lines[0][2], lines[1][0], lines[2][1]),
                Opposite(Multiplication(lines[0][2], lines[1][1], lines[2][0])),
                Opposite(Multiplication(lines[0][0], lines[1][2], lines[2][1])),
                Opposite(Multiplication(lines[0][1], lines[1][0], lines[2][2]))
            ).simplify()
        }
        return Double.nan
    }
    
    public required init(_ lines: [[Node]]) {
        self.lines = lines
    }
    
    public convenience init(_ lines: [Node]...) {
        self.init(lines)
    }
    
    public func simplify() -> Node {
        var simplifiedLines: [[Node]] = lines
        for i in 0..<linesCount {
            for j in 0..<columnsCount {
                simplifiedLines[i][j] = simplifiedLines[i][j].simplify()
            }
        }
        return Matrix(simplifiedLines)
    }
    
    public func toString() -> String {
        var string: String = "["
        lines.forEach { lines in
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
