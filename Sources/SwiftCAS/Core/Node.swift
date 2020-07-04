//
//  Node.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol Node {
    var sign: Sign { get }
    func toString() -> String
    func toLaTeX() -> String
    func integrate(of unknown: Unknown) -> Node
    func differentiate(of unknown: Unknown) -> Node
    func absoluteValue() -> Node
    func opposite() -> Node
    func simplify() -> Node
}

extension Node {
    func opposite() -> Node {
        return Opposite(self)
    }
    
    func absoluteValue() -> Node {
        return (sign == .Positive || sign == .Signless) ? self : AbsoluteValue(self)
    }
    
    func integrate() -> Node {
        return integrate(of: Unknown())
    }
    
    func differentiate() -> Node {
        return differentiate(of: Unknown())
    }
}
