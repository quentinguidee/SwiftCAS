//
//  Opposite.swift
//  
//
//  Created by Quentin Guidée on 03/07/2020.
//

public prefix func -(lhs: Node) -> Node { return Opposite(lhs) }

public class Opposite: Operator {
    var argument: Node
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
    
    public func simplified() -> Node {
        let simplified = argument.simplified().opposite()
        if let simplified = simplified as? Opposite {
            return Multiplication(-1, simplified.argument)
        } else {
            return simplified
        }
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
