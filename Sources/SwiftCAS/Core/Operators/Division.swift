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
        simplify(node: &numerator)
        simplify(node: &denominator)
        
        if let denominator = denominator as? NumericalValue, denominator.toDouble() == 1 {
            return numerator
        }
        
        return self
    }
    
    func differentiate(of unknown: Unknown) -> Node {
//        TODO: Substraction node
//        return Division(
//            Substraction(
//                Multiplication(numerator.differentiate(of: unknown), denominator),
//                Multiplication(numerator, denominator.differentiate(of: unknown))
//            ),
//            Pow(denominator, 2)
//        )
        return Differential(of: unknown, self)
    }
    
    func integrate(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}
