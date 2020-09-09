//
//  Integral.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

prefix operator ∫
public prefix func ∫(lhs: Node) -> Node { return Integral(lhs) }

public class Integral: Node {
    public private(set) var argument: Node
    public private(set) var unknown: Unknown
    public var sign: Sign { return .Positive }
    
    public required init(of unknown: Unknown, _ argument: Node) {
        self.unknown = unknown
        self.argument = argument
    }
    
    public convenience init(_ argument: Node) {
        self.init(of: Unknown(), argument)
    }
    
    public func shallowCopy() -> Self {
        return Self(of: unknown, argument)
    }
    
    public func simplified() -> Node {
        return argument.integrated(of: unknown)
    }
    
    public func prettified() -> Node {
        return Integral(of: unknown, argument.prettified())
    }
    
    public func toString() -> String {
        return "∫" + argument.toString() + " d" + unknown.toString()
    }
    
    public func toLaTeX() -> String {
        return "\\int{" + argument.toLaTeX() + "d" + unknown.toLaTeX() + "}"
    }
}

extension Integral: Differentiable {
    public func differentiated(of unknown: Unknown) -> Node {
        return self.unknown.symbol == unknown.symbol ? argument : Differential(of: unknown, self)
    }
}

extension Integral: Equatable {
    public static func == (lhs: Integral, rhs: Integral) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument) && lhs.unknown.isEqualTo(rhs.unknown)
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
