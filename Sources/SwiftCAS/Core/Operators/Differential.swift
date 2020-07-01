//
//  File.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

class Differential: Operator {
    var argument: Node
    var unknown: Unknown
    var sign: Sign { return .Positive }
    
    init(of unknown: Unknown, _ argument: Node) {
        self.unknown = unknown
        self.argument = argument
    }
    
    convenience init(_ argument: Node) {
        self.init(of: Unknown(), argument)
    }
    
    func simplify() -> Node {
        return argument.differentiate(of: unknown)
    }
    
    func toString() -> String {
        return "d/d" + unknown.symbol + "(" + argument.toString() + ")"
    }
    
    func toLaTeX() -> String {
        return "\\frac{d}{dx}\\left(" + argument.toString() + "\\right)"
    }
    
    func differentiate(of unknown: Unknown) -> Node {
        return Differential(of: unknown, self)
    }
    
    func integrate(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}
