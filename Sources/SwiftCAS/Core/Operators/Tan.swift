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
    
    public func shallowCopy() -> Node {
        return Tan(argument)
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
