//
//  Division.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public func /(lhs: Node, rhs: Node) -> Node { return Division(lhs, rhs) }

public class Division: Node {
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
    
    public func shallowCopy() -> Self {
        return Self(numerator, denominator)
    }
    
    public func simplified() -> Node {
        var numerator = self.numerator.simplified()
        var denominator = self.denominator.simplified()
        
        if let denominator = denominator as? NumericalValue, denominator.isNull() {
            return Double.nan
        } else if let numerator = numerator as? NumericalValue, numerator.isNull() {
            return 0
        }
        
        if let n = numerator as? Int, let d = denominator as? Int, let gcd = gcd(n, d) as? Int, gcd != 1 {
            numerator = n/gcd
            denominator = d/gcd
        }
        
        if let denominator = denominator as? NumericalValue, denominator.toDouble() == 1 {
            return numerator
        }
        
        // TODO: Remove this: should be simplified in the Multiplication node (3/2 = 3*2^(-1))
        if let numerator = numerator as? NumericalValue, let denominator = denominator as? NumericalValue, (numerator is Double || denominator is Double) {
            return numerator.toDouble()/denominator.toDouble()
        }
        
        return Division(numerator, denominator)
    }
    
    public func prettified() -> Node {
        return Division(numerator.prettified(), denominator.prettified())
    }
    
    public func toString() -> String {
        return numerator.toString() + "/" + denominator.toString()
    }
    
    public func toLaTeX() -> String {
        return "\\frac{" + numerator.toLaTeX() + "}{" + denominator.toLaTeX() + "}"
    }
}

extension Division: Differentiable {
    public func differentiated(of unknown: Unknown) -> Node {
        // (u/v) = (u'v-uv' / v^2)
        return Division(
            Addition(
                Multiplication(numerator.differentiated(of: unknown), denominator),
                Multiplication(numerator, denominator.differentiated(of: unknown)).opposite()
            ),
            Pow(denominator, 2)
        )
    }
}

extension Division: Integrable {
    public func integrated(of unknown: Unknown) -> Node {
        if numerator is NumericalValue && denominator is NumericalValue {
            return Multiplication(self, unknown)
        }
        return Integral(of: unknown, self)
    }
}

extension Division: Equatable {
    public static func == (lhs: Division, rhs: Division) -> Bool {
        return lhs.numerator.isEqualTo(rhs.numerator) && lhs.denominator.isEqualTo(rhs.denominator)
    }
}
