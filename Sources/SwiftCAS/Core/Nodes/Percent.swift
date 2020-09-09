//
//  Percent.swift
//  
//
//  Created by Quentin Guidée on 01/08/2020.
//

class Percent: Node {
    public private(set) var argument: Node
    public var sign: Sign { return .Positive }
    
    required init(_ argument: Node) {
        self.argument = argument
    }
    
    func shallowCopy() -> Self {
        return Self(argument)
    }
    
    func simplified() -> Node {
        if let argument = argument as? NumericalValue {
            return argument.toDouble() * 0.01
        }
        return shallowCopy()
    }
    
    public func prettified() -> Node {
        return Percent(argument.prettified())
    }
    
    func toString() -> String {
        return argument.toString() + "%"
    }
    
    func toLaTeX() -> String {
        return argument.toLaTeX() + "%"
    }
}

extension Percent: Equatable {
    static func == (lhs: Percent, rhs: Percent) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument)
    }
}
