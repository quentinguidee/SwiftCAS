//
//  SignOperator.swift
//  
//
//  Created by Quentin Guidée on 28/07/2020.
//

public class SignOperator: Operator {
    var argument: Node
    public var sign: Sign { return argument.sign }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    func shallowCopy() -> Self {
        return Self(argument)
    }
    
    public func simplified() -> Node {
        return sign == .Unknown ? shallowCopy() : sign.rawValue
    }
    
    public func toString() -> String {
        return "sign(\(argument.toString()))"
    }
    
    public func toLaTeX() -> String {
        return "sign(\(argument.toLaTeX()))"
    }
}
