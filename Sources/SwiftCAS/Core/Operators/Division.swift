//
//  Division.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

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
    
    public init(_ numerator: Node, _ denominator: Node) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    public func simplify() -> Node {
        numerator = numerator.simplify()
        denominator = denominator.simplify()
        
        if let numerator = numerator as? NumericalValue, numerator.isNull() {
            return 0
        } else if let denominator = denominator as? NumericalValue, denominator.toDouble() == 1 {
            return numerator
        }
        
        return self
    }
    
    public func toString() -> String {
        return numerator.toString() + "/" + denominator.toString()
    }
    
    public func toLaTeX() -> String {
        return "\\frac{" + numerator.toLaTeX() + "}{" + denominator.toLaTeX() + "}"
    }
}
