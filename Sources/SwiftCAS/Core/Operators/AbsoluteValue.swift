//
//  AbsoluteValue.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

public class AbsoluteValue: Operator {
    var argument: Node
    public var sign: Sign { return .Positive }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    public func shallowCopy() -> Node {
        return AbsoluteValue(argument)
    }
    
    public func simplified() -> Node {
        return argument.simplified().absoluteValue()
    }
    
    public func toString() -> String {
        return "|" + argument.toString() + "|"
    }
    
    public func toLaTeX() -> String {
        return "\\left|" + argument.toLaTeX() + "\\right|"
    }
}

public protocol AbsoluteValuable {
    func absoluteValue() -> Node
}

extension Node {
    public func absoluteValue() -> Node {
        return (sign == .Positive || sign == .Signless) ? self : AbsoluteValue(self)
    }
}

extension NumericalValue {
    public func absoluteValue() -> Node {
        return sign == .Negative ? self.opposite() : self
    }
}
