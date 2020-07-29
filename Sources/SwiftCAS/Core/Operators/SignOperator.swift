//
//  SignOperator.swift
//  
//
//  Created by Quentin Guidée on 28/07/2020.
//

class SignOperator: Operator {
    var argument: Node
    public var sign: Sign { return argument.sign }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    public func simplified() -> Node {
        switch argument.sign {
            case .Positive: return 1
            case .Signless: return 0
            case .Negative: return -1
            case .Unknown: return SignOperator(argument)
        }
    }
    
    public func toString() -> String {
        return "sign(\(argument.toString()))"
    }
    
    public func toLaTeX() -> String {
        return toString()
    }
}
