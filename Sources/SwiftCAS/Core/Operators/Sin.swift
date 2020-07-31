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
    
    public func shallowCopy() -> Node {
        return Sin(argument)
    }
    
    public func simplified() -> Node {
        return shallowCopy()
    }
    
    public func toString() -> String {
        return "sin(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\sin{(" + argument.toLaTeX() + ")}"
    }
}
