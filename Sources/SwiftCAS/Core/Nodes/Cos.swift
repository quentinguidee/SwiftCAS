//
//  Cos.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

public typealias Cosine = Cos

public class Cos: Node {
    var argument: Node
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
        return Cos(argument.prettified())
    }
    
    public func toString() -> String {
        return "cos(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\cos{(" + argument.toLaTeX() + ")}"
    }
}

extension Cos: Differentiable {
    public func differentiated(of unknown: Unknown) -> Node {
        return Multiplication(argument.differentiated(of: unknown), Opposite(Sin(argument)))
    }
}

extension Cos: Equatable {
    public static func == (lhs: Cos, rhs: Cos) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument)
    }
}
