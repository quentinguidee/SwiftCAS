//
//  Tan.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

public typealias Tangent = Tan

public class Tan: Node {
    public private(set) var argument: Node
    public var sign: Sign { return .Unknown }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    public func shallowCopy() -> Self {
        return Self(argument)
    }
    
    public func simplified() -> Node {
        return shallowCopy()
    }
    
    public func prettified() -> Node {
        return Tan(argument.prettified())
    }
    
    public func toString() -> String {
        return "tan(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\tan{(" + argument.toLaTeX() + ")}"
    }
}

extension Tan: Differentiable {
    public func differentiated(of unknown: Unknown) -> Node {
        return Division(Sin(argument), Cos(argument))
            .differentiated(of: unknown)
    }
}

extension Tan: Equatable {
    public static func == (lhs: Tan, rhs: Tan) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument)
    }
}
