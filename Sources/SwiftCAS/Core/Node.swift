//
//  Node.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol Node: Differentiable, Integrable {
    var sign: Sign { get }
    func simplify() -> Node
    func toString() -> String
    func toLaTeX() -> String
    func absoluteValue() -> Node
    func opposite() -> Node
}

extension Node {
    func opposite() -> Node {
        return Opposite(self)
    }
    
    func absoluteValue() -> Node {
        return (sign == .Positive || sign == .Signless) ? self : AbsoluteValue(self)
    }
}
