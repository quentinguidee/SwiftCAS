//
//  Tan.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

public typealias Tangent = Tan

public class Tan: Operator {
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
    
    public func toString() -> String {
        return "tan(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\tan{(" + argument.toLaTeX() + ")}"
    }
}

extension Tan: Equatable {
    public static func == (lhs: Tan, rhs: Tan) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument)
    }
}
