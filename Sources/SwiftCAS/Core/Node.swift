//
//  Node.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public protocol Node: Differentiable, Integrable, AbsoluteValuable, Opposable {
    var sign: Sign { get }
    
    func shallowCopy() -> Self
    func inverse() -> Node
    func simplified() -> Node
    func toString() -> String
    func toLaTeX() -> String
}

extension Node {
    public func inverse() -> Node {
        return Pow(self, -1)
    }
}
