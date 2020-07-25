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
    
    var sign: Sign {
        if denominator.sign == .Signless {
            // Result = Infinity, we take the numerator sign.
            return numerator.sign
        } else {
            // sign(numerator) * sign(denominator)
            return Sign(rawValue: numerator.sign.rawValue * denominator.sign.rawValue)!
        }
    }
    
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
    
    func simplify() -> Node {
        numerator = numerator.simplify()
        denominator = denominator.simplify()
        
        if let numerator = numerator as? NumericalValue, numerator.isNull() {
            return 0
        } else if let denominator = denominator as? NumericalValue, denominator.toDouble() == 1 {
            return numerator
        }
        
        return self
    }
}
