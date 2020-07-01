//
//  AbsoluteValue.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

class AbsoluteValue: Operator {
    var argument: Node
    var sign: Sign { return .Positive }
    
    init(_ argument: Node) {
        self.argument = argument
    }
    
    func simplify() -> Node {
        return argument.absoluteValue()
    }
    
    func toString() -> String {
        return "|" + argument.toString() + "|"
    }
    
    func toLaTeX() -> String {
        return "\\left|" + argument.toLaTeX() + "\\right|"
    }
    
    func absoluteValue() -> Node {
        return self
    }
}