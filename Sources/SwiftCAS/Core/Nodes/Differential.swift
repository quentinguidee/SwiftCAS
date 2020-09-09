//
//  Differential.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

public class Differential: Node {
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
        return argument.differentiated(of: unknown)
    }
    
    public func prettified() -> Node {
        return Differential(of: unknown, argument.prettified())
    }
    
    public func toString() -> String {
        return "d/d" + unknown.symbol + "(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\frac{d}{dx}\\left(" + argument.toLaTeX() + "\\right)"
    }
}

extension Differential: Integrable {
    public func integrated(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}

extension Differential: Equatable {
    public static func == (lhs: Differential, rhs: Differential) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument) && lhs.unknown.isEqualTo(rhs.unknown)
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
