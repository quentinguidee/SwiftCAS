//
//  Root.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

public class Root: Operator {
    public var sign: Sign { return .Positive }
    var radicand: Node
    var index: Node
    
    public init(_ radicand: Node, _ index: Node) {
        self.radicand = radicand
        self.index = index
    }
    
    public convenience init(_ radicand: Node) {
        self.init(radicand, 2)
    }
    
    public func simplify() -> Node {
        return Multiplication(radicand, Division(1, index)).simplify()
    }
    
    public func toString() -> String {
        if isSquareRoot() {
            return "sqrt(" + radicand.toString() + ")"
        } else if isCubeRoot() {
            return "cbrt(" + radicand.toString() + ")"
        } else {
            return "root(" + radicand.toString() + ", " + index.toString() + ")"
        }
    }
    
    public func toLaTeX() -> String {
        if isSquareRoot() {
            return "\\sqrt{" + radicand.toLaTeX() + "}"
        } else {
            return "\\sqrt[" + index.toLaTeX() + "]{" + radicand.toLaTeX() + "}"
        }
    }
    
    public func isSquareRoot() -> Bool {
        let i = index as? NumericalValue
        return i?.toDouble() == 2 ? true : false
    }
    
    public func isCubeRoot() -> Bool {
        let i = index as? NumericalValue
        return i?.toDouble() == 3 ? true : false
    }
}
