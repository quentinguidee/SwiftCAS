//
//  Sin.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

public typealias Sine = Sin

public class Sin: Operator {
    var argument: Node
    public var sign: Sign { return .Unknown }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    public func simplify() -> Node {
        return self
    }
    
    public func toString() -> String {
        return "sin(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\sin{(" + argument.toLaTeX() + ")}"
    }
}
