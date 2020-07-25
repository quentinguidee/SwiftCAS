//
//  Cos.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

class Cos: Operator {
    var argument: Node
    var sign: Sign { return .Unknown }
    
    init(_ argument: Node) {
        self.argument = argument
    }
    
    func simplify() -> Node {
        return self
    }
    
    func toString() -> String {
        return "cos(" + argument.toString() + ")"
    }
    
    func toLaTeX() -> String {
        return "\\cos{(" + argument.toLaTeX() + ")}"
    }
    
    func differentiated(of unknown: Unknown) -> Node {
        return Multiplication(argument.differentiated(of: unknown), Opposite(Sin(argument)))
    }
    
    func integrated(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}
