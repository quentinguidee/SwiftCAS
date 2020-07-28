//
//  Integral.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

prefix operator ∫
public prefix func ∫(lhs: Node) -> Node { return Integral(lhs) }

public class Integral: Operator {
    var argument: Node
    var unknown: Unknown
    public var sign: Sign { return .Positive }
    
    public required init(of unknown: Unknown, _ argument: Node) {
        self.unknown = unknown
        self.argument = argument
    }
    
    public convenience init(_ argument: Node) {
        self.init(of: Unknown(), argument)
    }
    
    public func simplify() -> Node {
        return argument.integrated(of: unknown)
    }
    
    public func toString() -> String {
        return "∫" + argument.toString() + " d" + unknown.toString()
    }
    
    public func toLaTeX() -> String {
        return "\\int{" + argument.toLaTeX() + "d" + unknown.toLaTeX() + "}"
    }
}

public protocol Integrable {
    func integrated() -> Node
    func integrated(of unknown: Unknown) -> Node
}

extension Node {
    public func integrated() -> Node {
        return integrated(of: Unknown())
    }
    
    public func integrated(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}

extension AbsoluteValue {
    public func integrated(of unknown: Unknown) -> Node {
        if argument.sign == .Positive {
            return argument.integrated(of: unknown)
        } else {
            return Multiplication(argument.integrated(of: unknown), SignOperator(unknown))
        }
    }
}

extension Addition {
    public func integrated(of unknown: Unknown) -> Node {
        var nodes: [Node] = []
        children.forEach({ nodes.append($0.integrated(of: unknown)) })
        return Addition(nodes)
    }
}

extension Differential {
    public func integrated(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}

extension Division {
    public func integrated(of unknown: Unknown) -> Node {
        if numerator is NumericalValue && denominator is NumericalValue {
            return Multiplication(self, unknown)
        }
        return Integral(of: unknown, self)
    }
}

extension Infinity {
    public func integrated(of unknown: Unknown) -> Node {
        return self
    }
}

extension Opposite {
    public func integrated(of unknown: Unknown) -> Node {
        return Opposite(argument.integrated(of: unknown))
    }
}

extension Pow {
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

extension Unknown {
    public func integrated(of unknown: Unknown) -> Node {
        if symbol == unknown.symbol {
            return Division(Pow(self, 2), 2)
        } else {
            return Multiplication(self, unknown)
        }
    }
}

extension Value {
    public func integrated(of unknown: Unknown) -> Node {
        return Multiplication(self, unknown)
    }
}
