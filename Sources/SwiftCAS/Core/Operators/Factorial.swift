//
//  Factorial.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

public typealias Fact = Factorial

public class Factorial: Node {
    var argument: Node
    public var sign: Sign { return .Positive }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    public func shallowCopy() -> Self {
        return Self(argument)
    }
    
    public func simplified() -> Node {
        if let argument = argument as? Int {
            return argument.factorial()
        } else if let argument = argument as? Factorial {
            return argument.simplified().factorial().simplified()
        }
        
        return shallowCopy()
    }
    
    public func toString() -> String {
        return argument.toString() + "!"
    }
    
    public func toLaTeX() -> String {
        return argument.toLaTeX() + "!"
    }
}

extension Factorial: Equatable {
    public static func == (lhs: Factorial, rhs: Factorial) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument)
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
