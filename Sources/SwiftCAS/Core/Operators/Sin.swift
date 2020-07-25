//
//  Sin.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

class Sin: Operator {
    var argument: Node
    var sign: Sign { return .Unknown }
    
    init(_ argument: Node) {
        self.argument = argument
    }
    
    func simplify() -> Node {
        return self
    }
    
    func toString() -> String {
        return "sin(" + argument.toString() + ")"
    }
    
    func toLaTeX() -> String {
        return "\\sin{(" + argument.toLaTeX() + ")}"
    }
    
    func differentiated(of unknown: Unknown) -> Node {
        return Multiplication(argument.differentiated(of: unknown), Cos(argument))
    }
    
    func integrated(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}
