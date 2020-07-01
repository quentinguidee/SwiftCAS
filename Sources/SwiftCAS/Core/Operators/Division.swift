//
//  Division.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Division: Operator {
    var numerator: Node
    var denominator: Node
    var dividend: Node { return numerator }
    var divisor: Node { return denominator }
    
    init(_ numerator: Node, _ denominator: Node) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func toString() -> String {
        return numerator.toString() + "/" + denominator.toString()
    }
    
    func toLaTeX() -> String {
        return "\\frac{" + numerator.toLaTeX() + "}{" + denominator.toLaTeX() + "}"
    }
    
    /*
     Rules:
     
     x/1        -> x
     x/0        -> ERR
     cst/cst    -> 1
     */
    func simplify() -> Node {
        if let denominator = denominator as? NumericalValue, denominator.toDouble() == 1 {
            return numerator
        }
        return self
    }
}
