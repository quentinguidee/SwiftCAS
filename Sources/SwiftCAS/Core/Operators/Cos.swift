//
//  Cos.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

public typealias Cosine = Cos

public class Cos: Operator {
    var argument: Node
    public var sign: Sign { return .Unknown }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    public func simplify() -> Node {
        return self
    }
    
    public func toString() -> String {
        return "cos(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\cos{(" + argument.toLaTeX() + ")}"
    }
}
