//
//  Integral.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

class Integral: Operator {
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
        return argument.integrate()
    }
    
    func toString() -> String {
        return "∫" + argument.toString() + " d" + unknown.toString()
    }
    
    func toLaTeX() -> String {
        return "\\int{" + argument.toLaTeX() + "d" + unknown.toLaTeX() + "}"
    }
    
    func integrate(of unknown: Unknown) -> Node {
        return Integral(of: unknown, self)
    }
}
