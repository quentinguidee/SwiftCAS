//
//  Cos.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

public typealias Cosine = Cos

public class Cos: Operator {
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
        return "cos(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\cos{(" + argument.toLaTeX() + ")}"
    }
}

extension Cos: Equatable {
    public static func == (lhs: Cos, rhs: Cos) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument)
    }
}
