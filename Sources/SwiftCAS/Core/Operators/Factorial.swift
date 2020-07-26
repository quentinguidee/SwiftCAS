//
//  Factorial.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

public class Factorial: Operator {
    var argument: Node
    public var sign: Sign { return .Positive }
    
    public init(_ argument: Node) {
        self.argument = argument
    }
    
    public func simplify() -> Node {
        if let argument = argument as? Int {
            return argument.factorial()
        }
        
        return self
    }
    
    public func toString() -> String {
        return argument.toString() + "!"
    }
    
    public func toLaTeX() -> String {
        return argument.toLaTeX() + "!"
    }
}

extension Node {
    public func factorial() -> Node {
        return Factorial(self)
    }
}

extension Int {
    public func factorial() -> Node {
        var result = 1
        var i = self
        
        if i > 20 || i < 0 { return Infinity() }
        
        while i > 1 {
            result *= i
            i -= 1
        }
        
        return result
    }
}