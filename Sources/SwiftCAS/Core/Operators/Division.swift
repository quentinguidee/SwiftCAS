//
//  Division.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public func /(lhs: Node, rhs: Node) -> Node { return Division(lhs, rhs) }

public class Division: Operator {
    public private(set) var numerator: Node
    public private(set) var denominator: Node
    public var dividend: Node { return numerator }
    public var divisor: Node { return denominator }
    
    public var sign: Sign {
        if denominator.sign == .Signless {
            // Result = Infinity, we take the numerator sign.
            return numerator.sign
        } else {
            // sign(numerator) * sign(denominator)
            return Sign(rawValue: numerator.sign.rawValue * denominator.sign.rawValue)!
        }
    }
    
    public required init(_ numerator: Node, _ denominator: Node) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    public func simplified() -> Node {
        var numerator = self.numerator.simplified()
        var denominator = self.denominator.simplified()
        
        if let numerator = numerator as? NumericalValue, numerator.isNull() {
            return 0
        }
        
        if let n = numerator as? Int, let d = denominator as? Int, let gcd = gcd(n, d) as? Int, gcd != 1 {
            numerator = n/gcd
            denominator = d/gcd
        }
        
        if let denominator = denominator as? NumericalValue, denominator.toDouble() == 1 {
            return numerator
        }
        
        return Division(numerator, denominator)
    }
    
    public func toString() -> String {
        return numerator.toString() + "/" + denominator.toString()
    }
    
    public func toLaTeX() -> String {
        return "\\frac{" + numerator.toLaTeX() + "}{" + denominator.toLaTeX() + "}"
    }
}
