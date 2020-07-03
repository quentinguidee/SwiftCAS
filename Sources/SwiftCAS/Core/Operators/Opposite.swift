//
//  Opposite.swift
//  
//
//  Created by Quentin Guidée on 03/07/2020.
//

class Opposite: Operator {
    var argument: Node
    var sign: Sign {
        switch argument.sign {
            case .Positive:
                return .Negative
            case .Negative:
                return .Positive
            default:
                return argument.sign
        }
    }
    
    init(_ argument: Node) {
        self.argument = argument
    }
    
    func simplify() -> Node {
        return argument.opposite()
    }
    
    func opposite() -> Node {
        return argument
    }
    
    func toString() -> String {
        return "-" + argument.toString()
    }
    
    func toLaTeX() -> String {
        return "-" + argument.toLaTeX()
    }
    
    func differentiate(of unknown: Unknown) -> Node {
        return Opposite(argument.differentiate(of: unknown))
    }
    
    func integrate(of unknown: Unknown) -> Node {
        return Opposite(argument.integrate(of: unknown))
    }
}
