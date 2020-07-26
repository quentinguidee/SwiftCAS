//
//  Node.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol Node: Differentiable, Integrable, AbsoluteValuable {
    var sign: Sign { get }
    func simplify() -> Node
    func toString() -> String
    func toLaTeX() -> String
    func opposite() -> Node
}

extension Node {
    func opposite() -> Node {
        return Opposite(self)
    }
}
