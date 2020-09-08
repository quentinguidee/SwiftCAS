//
//  Pow.swift
//  
//
//  Created by Quentin Guidée on 28/06/2020.
//

import Foundation

infix operator **
public func ^(lhs: Node, rhs: Node) -> Node { return Pow(lhs, rhs) }
public func **(lhs: Node, rhs: Node) -> Node { return lhs^rhs }

public typealias Power = Pow

public class Pow: Node {
    public private(set) var base: Node
    public private(set) var power: Node
    
    public var sign: Sign {
        switch base.sign {
            case .Positive:
                return .Positive
            case .Signless:
                return .Signless
            case .Negative:
                if let power = power as? Int {
                    return power.isEven() ? .Positive : .Negative
                }
            case .Unknown:
                if let power = power as? Int {
                    return power.isEven() ? .Positive : .Unknown
                }
        }
        return .Unknown
    }
    
    public required init(_ base: Node, _ power: Node) {
        self.base = base
        self.power = power
    }
    
    public func shallowCopy() -> Self {
        return Self(base, power)
    }
    
    public func simplified() -> Node {
        let base = self.base.simplified()
        let power = self.power.simplified()
        
        if let base = base as? NumericalValue, base.toDouble() == 1 {
            return 1
        } else if let power = power as? NumericalValue, power.toDouble() == 1 {
            return base
        } else if let base = base as? Pow {
            return Pow(base.base, Multiplication(base.power, power))
        } else if let base = base as? Multiplication {
            return Multiplication(base.children.map { return Pow($0, power) }).simplified()
        } else if let base = base as? NumericalValue, let power = power as? NumericalValue {
            return pow(base.toDouble(), power.toDouble()).toIntIfPossible()
        }
        
        return Pow(base, power)
    }
    
    public func prettified() -> Node {
        if let power = power as? NumericalValue, power.toDouble() == -1 {
            return Division(1, base.prettified())
        }
        return Pow(base.prettified(), power.prettified())
    }
    
    public func toString() -> String {
        return base.toString() + "^" + power.toString()
    }
    
    public func toLaTeX() -> String {
        return "{" + base.toLaTeX() + "}^{" + power.toLaTeX() + "}"
    }
}

extension Pow: Differentiable {
    public func differentiated(of unknown: Unknown) -> Node {
        if let base = base as? Unknown {
            if (base.symbol == unknown.symbol) {
                return Multiplication(power, Pow(base, Addition(power, -1)))
            }
        } else if let base = base as? Constant, let power = power as? Unknown {
            if (base.symbol == "e" && power.symbol == unknown.symbol) {
                return Pow(base, power)
            }
        }
        
        return 0
    }
}

extension Pow: Integrable {
    public func integrated(of unknown: Unknown) -> Node {
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

extension Pow: Equatable {
    public static func == (lhs: Pow, rhs: Pow) -> Bool {
        return lhs.base.isEqualTo(rhs.base) && lhs.power.isEqualTo(rhs.power)
    }
}
