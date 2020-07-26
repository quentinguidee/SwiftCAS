//
//  Integral.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

class Integral: Operator {
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
        return argument.integrated()
    }
    
    func toString() -> String {
        return "∫" + argument.toString() + " d" + unknown.toString()
    }
    
    func toLaTeX() -> String {
        return "\\int{" + argument.toLaTeX() + "d" + unknown.toLaTeX() + "}"
    }
}

protocol Integrable {
    func integrated() -> Node
    func integrated(of unknown: Unknown) -> Node
}

extension Node {
    func integrated() -> Node {
        return integrated(of: Unknown())
    }
    
    func integrated(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}

extension Addition {
    func integrated(of unknown: Unknown) -> Node {
        var nodes: [Node] = []
        children.forEach({ nodes.append($0.integrated(of: unknown)) })
        return Addition(nodes)
    }
}

extension Differential {
    func integrated(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}

extension Division {
    func integrated(of unknown: Unknown) -> Node {
        if numerator is NumericalValue && denominator is NumericalValue {
            return Multiplication(self, unknown)
        }
        return Integral(of: unknown, self)
    }
}

extension Infinity {
    func integrated(of unknown: Unknown) -> Node {
        return self
    }
}

extension Opposite {
    func integrated(of unknown: Unknown) -> Node {
        return Opposite(argument.integrated(of: unknown))
    }
}

extension Pow {
    func integrated(of unknown: Unknown) -> Node {
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
    func integrated(of unknown: Unknown) -> Node {
        if symbol == unknown.symbol {
            return Division(Pow(self, 2), 2)
        } else {
            return Multiplication(self, unknown)
        }
    }
}

extension Value {
    func integrated(of unknown: Unknown) -> Node {
        return Multiplication(self, unknown)
    }
}
