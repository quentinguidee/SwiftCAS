//
//  Node.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public protocol Node: Differentiable, Integrable, AbsoluteValuable, Opposable {
    var sign: Sign { get }
    
    func simplified() -> Node
    func toString() -> String
    func toLaTeX() -> String
}
