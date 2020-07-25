//
//  Tan.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

class Tan: Operator {
    var argument: Node
    var sign: Sign { return .Unknown }
    
    init(_ argument: Node) {
        self.argument = argument
    }
    
    func simplify() -> Node {
        return self
    }
    
    func toString() -> String {
        return "tan(" + argument.toString() + ")"
    }
    
    func toLaTeX() -> String {
        return "\\tan{(" + argument.toLaTeX() + ")}"
    }
    
    func differentiated(of unknown: Unknown) -> Node {
        return Division(Sin(argument), Cos(argument))
            .differentiated(of: unknown)
    }
    
    func integrated(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}
