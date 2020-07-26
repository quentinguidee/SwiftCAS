//
//  Opposite.swift
//  
//
//  Created by Quentin Guidée on 03/07/2020.
//

class Opposite: Operator {
    var argument: Node
    var sign: Sign {
        switch argument.sign {
            case .Positive:
                return .Negative
            case .Negative:
                return .Positive
            default:
                return argument.sign
        }
    }
    
    init(_ argument: Node) {
        self.argument = argument
    }
    
    func simplify() -> Node {
        return argument.simplify().opposite()
    }
    
    func opposite() -> Node {
        return argument
    }
    
    func toString() -> String {
        return "-" + argument.toString()
    }
    
    func toLaTeX() -> String {
        return "-" + argument.toLaTeX()
    }
}

protocol Opposable {
    func opposite() -> Node
}

extension Node {
    func opposite() -> Node {
        return Opposite(self)
    }
}

extension Double {
    func opposite() -> Node {
        return -self
    }
}

extension Int {
    func opposite() -> Node {
        return -self
    }
}
