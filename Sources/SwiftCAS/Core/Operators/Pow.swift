//
//  Pow.swift
//  
//
//  Created by Quentin Guidée on 28/06/2020.
//

import Foundation

class Pow: Operator {
    var base: Node
    var power: Node
    
    var sign: Sign {
        switch base.sign {
            case .Positive:
                return .Positive
            case .Signless:
                return .Signless
            default:
                if let power = power as? Int {
                    if power.isEven() {
                        return .Positive
                    } else {
                        return .Negative
                    }
            }
        }
        
        return .Signless
    }
    
    init(_ base: Node, _ power: Node) {
        self.base = base
        self.power = power
    }
    
    func toString() -> String {
        return base.toString() + "^" + power.toString()
    }
    
    func toLaTeX() -> String {
        return "{" + base.toLaTeX() + "}^{" + power.toLaTeX() + "}"
    }
    
    func simplify() -> Node {
        base = base.simplify()
        power = power.simplify()
        
        if let base = base as? NumericalValue, base.toDouble() == 1 {
            return 1
        } else if let power = power as? NumericalValue, power.toDouble() == 1 {
            return base
        } else if let base = base as? Pow {
            return Pow(base.base, Multiplication(base.power, power))
        } else if let base = base as? Multiplication {
            var n: [Pow] = []
            base.children.forEach { child in n.append(Pow(child, power)) }
            return Multiplication(n).simplify()
        } else if let base = base as? NumericalValue, let power = power as? NumericalValue {
            return pow(base.toDouble(), power.toDouble()).toIntIfPossible()
        }
        
        return self
    }
    
    func differentiate(of unknown: Unknown) -> Node {
        if let base = base as? Unknown {
            if (base.symbol == unknown.symbol) {
                return Multiplication(power, Pow(base, Addition(power, -1)))
            }
        } else if let base = base as? Constant, let power = power as? Unknown {
            if (base.symbol == "e" && power.symbol == unknown.symbol) {
                return self
            }
        }
        
        return 0
    }
    
    func integrate(of unknown: Unknown) -> Node {
        if let base = base as? Unknown, let power = power as? NumericalValue {
            if base.symbol == unknown.symbol {
                return Multiplication(
                    Division(1, Addition(power, 1)),
                    Pow(base, Addition(power, 1))
                )
            } else {
                return Multiplication(unknown, self)
            }
        }
        
        return Integral(of: unknown, self)
    }
}
