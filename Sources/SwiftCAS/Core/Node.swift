//
//  Node.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol Node {
    var sign: Sign { get }
    func simplify() -> Node
    func toString() -> String
    func toLaTeX() -> String
    func absoluteValue() -> Node
    func opposite() -> Node
    func differentiated(of unknown: Unknown) -> Node
    func integrated(of unknown: Unknown) -> Node
}

extension Node {
    func opposite() -> Node {
        return Opposite(self)
    }
    
    func absoluteValue() -> Node {
        return (sign == .Positive || sign == .Signless) ? self : AbsoluteValue(self)
    }
    
    func integrated() -> Node {
        return integrated(of: Unknown())
    }
    
    func differentiated() -> Node {
        return differentiated(of: Unknown())
    }
}
