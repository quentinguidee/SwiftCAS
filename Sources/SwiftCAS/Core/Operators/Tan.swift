//
//  Tan.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

public class Tan: Operator {
    var argument: Node
    public var sign: Sign { return .Unknown }
    
    public init(_ argument: Node) {
        self.argument = argument
    }
    
    public func simplify() -> Node {
        return self
    }
    
    public func toString() -> String {
        return "tan(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\tan{(" + argument.toLaTeX() + ")}"
    }
}
