//
//  File.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

class Differential: Operator {
    var argument: Node
    var unknown: Unknown
    var sign: Sign { return .Positive }
    
    init(of unknown: Unknown, _ argument: Node) {
        self.unknown = unknown
        self.argument = argument
    }
    
    convenience init(_ argument: Node) {
        self.init(of: Unknown(), argument)
    }
    
    func simplify() -> Node {
        return argument.differentiated(of: unknown)
    }
    
    func toString() -> String {
        return "d/d" + unknown.symbol + "(" + argument.toString() + ")"
    }
    
    func toLaTeX() -> String {
        return "\\frac{d}{dx}\\left(" + argument.toString() + "\\right)"
    }
}

protocol Differentiable {
    func differentiated() -> Node
    func differentiated(of unknown: Unknown) -> Node
}

extension Node {
    func differentiated() -> Node {
        return differentiated(of: Unknown())
    }
    
    func differentiated(of unknown: Unknown) -> Node {
        return Differential(of: unknown, self)
    }
}

extension AbsoluteValue {
    func differentiated(of unknown: Unknown) -> Node {
        return Multiplication(
            Division(self, self.argument),
            argument.differentiated(of: unknown)
        )
    }
}

extension Addition {
    func differentiated(of unknown: Unknown) -> Node {
        var nodes: [Node] = []
        children.forEach({ nodes.append($0.differentiated(of: unknown)) })
        return Addition(nodes)
    }
}

extension Cos {
    func differentiated(of unknown: Unknown) -> Node {
        return Multiplication(argument.differentiated(of: unknown), Opposite(Sin(argument)))
    }
}

extension Division {
    func differentiated(of unknown: Unknown) -> Node {
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
    func differentiated(of unknown: Unknown) -> Node {
        return self.unknown.symbol == unknown.symbol ? argument : Differential(of: unknown, self)
    }
}

extension Opposite {
    func differentiated(of unknown: Unknown) -> Node {
        return Opposite(argument.differentiated(of: unknown))
    }
}

extension Pow {
    func differentiated(of unknown: Unknown) -> Node {
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
}

extension Sin {
    func differentiated(of unknown: Unknown) -> Node {
        return Multiplication(argument.differentiated(of: unknown), Cos(argument))
    }
}

extension Tan {
    func differentiated(of unknown: Unknown) -> Node {
        return Division(Sin(argument), Cos(argument))
            .differentiated(of: unknown)
    }
}

extension Unknown {
    func differentiated(of unknown: Unknown) -> Node {
        return symbol == unknown.symbol ? 1 : 0
    }
}

extension Value {
    func differentiated(of unknown: Unknown) -> Node {
        return 0
    }
}
