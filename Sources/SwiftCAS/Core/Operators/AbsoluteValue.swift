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
}

protocol AbsoluteValuable {
    func absoluteValue() -> Node
}

extension Node {
    func absoluteValue() -> Node {
        return (sign == .Positive || sign == .Signless) ? self : AbsoluteValue(self)
    }
}

extension NumericalValue {
    func absoluteValue() -> Node {
        return sign == .Negative ? self.opposite() : self
    }
}
