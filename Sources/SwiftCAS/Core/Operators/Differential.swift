//
//  Differential.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

public class Differential: Operator {
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
    
    public func shallowCopy() -> Node {
        return Differential(of: unknown, argument)
    }
    
    public func simplified() -> Node {
        return argument.differentiated(of: unknown)
    }
    
    public func toString() -> String {
        return "d/d" + unknown.symbol + "(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\frac{d}{dx}\\left(" + argument.toLaTeX() + "\\right)"
    }
}

public protocol Differentiable {
    func differentiated() -> Node
    func differentiated(of unknown: Unknown) -> Node
}

extension Node {
    public func differentiated() -> Node {
        return differentiated(of: Unknown())
    }
    
    public func differentiated(of unknown: Unknown) -> Node {
        return Differential(of: unknown, self)
    }
}

extension AbsoluteValue {
    public func differentiated(of unknown: Unknown) -> Node {
        return Multiplication(
            Division(self, self.argument),
            argument.differentiated(of: unknown)
        )
    }
}

extension Addition {
    public func differentiated(of unknown: Unknown) -> Node {
        var nodes: [Node] = []
        children.forEach({ nodes.append($0.differentiated(of: unknown)) })
        return Addition(nodes)
    }
}

extension Cos {
    public func differentiated(of unknown: Unknown) -> Node {
        return Multiplication(argument.differentiated(of: unknown), Opposite(Sin(argument)))
    }
}

extension Division {
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

extension Integral {
    public func differentiated(of unknown: Unknown) -> Node {
        return self.unknown.symbol == unknown.symbol ? argument : Differential(of: unknown, self)
    }
}

extension Opposite {
    public func differentiated(of unknown: Unknown) -> Node {
        return Opposite(argument.differentiated(of: unknown))
    }
}

extension Pow {
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

extension Sin {
    public func differentiated(of unknown: Unknown) -> Node {
        return Multiplication(argument.differentiated(of: unknown), Cos(argument))
    }
}

extension Tan {
    public func differentiated(of unknown: Unknown) -> Node {
        return Division(Sin(argument), Cos(argument))
            .differentiated(of: unknown)
    }
}

extension Unknown {
    public func differentiated(of unknown: Unknown) -> Node {
        return symbol == unknown.symbol ? 1 : 0
    }
}

extension Value {
    public func differentiated(of unknown: Unknown) -> Node {
        return 0
    }
}
