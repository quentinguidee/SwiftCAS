//
//  Opposite.swift
//  
//
//  Created by Quentin Guidée on 03/07/2020.
//

public prefix func -(lhs: Node) -> Node { return Opposite(lhs) }

public class Opposite: Node {
    public private(set) var argument: Node
    public var sign: Sign {
        switch argument.sign {
            case .Positive:
                return .Negative
            case .Negative:
                return .Positive
            default:
                return argument.sign
        }
    }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    public func shallowCopy() -> Self {
        return Self(argument)
    }
    
    public func simplified() -> Node {
        let simplified = argument.simplified().opposite()
        if let simplified = simplified as? Opposite {
            return Multiplication(-1, simplified.argument)
        } else {
            return simplified
        }
    }
    
    public func prettified() -> Node {
        return Opposite(argument.prettified())
    }
    
    public func opposite() -> Node {
        return argument
    }
    
    public func toString() -> String {
        return "-" + argument.toString()
    }
    
    public func toLaTeX() -> String {
        return "-" + argument.toLaTeX()
    }
}

extension Opposite: Differentiable {
    public func differentiated(of unknown: Unknown) -> Node {
        return Opposite(argument.differentiated(of: unknown))
    }
}

extension Opposite: Integrable {
    public func integrated(of unknown: Unknown) -> Node {
        return Opposite(argument.integrated(of: unknown))
    }
}

extension Opposite: Equatable {
    public static func == (lhs: Opposite, rhs: Opposite) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument)
    }
}

public protocol Opposable {
    func opposite() -> Node
}

extension Node {
    public func opposite() -> Node {
        return Opposite(self)
    }
}

extension Double {
    public func opposite() -> Node {
        var n = self
        n.negate()
        return n
    }
}

extension Int {
    public func opposite() -> Node {
        var n = self
        n.negate()
        return n
    }
}
