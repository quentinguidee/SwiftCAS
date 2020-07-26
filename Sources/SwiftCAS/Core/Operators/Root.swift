//
//  Root.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

class Root: Operator {
    var sign: Sign { return .Positive }
    var radicand: Node
    var index: Node
    
    init(_ radicand: Node, _ index: Node) {
        self.radicand = radicand
        self.index = index
    }
    
    convenience init(_ radicand: Node) {
        self.init(radicand, 2)
    }
    
    func simplify() -> Node {
        return Multiplication(radicand, Division(1, index)).simplify()
    }
    
    func toString() -> String {
        if isSquareRoot() {
            return "sqrt(" + radicand.toString() + ")"
        } else if isCubeRoot() {
            return "cbrt(" + radicand.toString() + ")"
        } else {
            return "root(" + radicand.toString() + ", " + index.toString() + ")"
        }
    }
    
    func toLaTeX() -> String {
        if isSquareRoot() {
            return "\\sqrt{" + radicand.toLaTeX() + "}"
        } else {
            return "\\sqrt[" + index.toLaTeX() + "]{" + radicand.toLaTeX() + "}"
        }
    }
    
    func isSquareRoot() -> Bool {
        let i = index as? NumericalValue
        return i?.toDouble() == 2 ? true : false
    }
    
    func isCubeRoot() -> Bool {
        let i = index as? NumericalValue
        return i?.toDouble() == 3 ? true : false
    }
}
