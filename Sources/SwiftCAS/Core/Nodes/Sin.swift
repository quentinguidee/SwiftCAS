//
//  Sin.swift
//  
//
//  Created by Quentin Guidée on 25/07/2020.
//

public typealias Sine = Sin

public class Sin: Node {
    var argument: Node
    public var sign: Sign { return .Unknown }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    public func shallowCopy() -> Self {
        return Self(argument)
    }
    
    public func simplified() -> Node {
        return shallowCopy()
    }
    
    public func prettified() -> Node {
        return Sin(argument.prettified())
    }
    
    public func toString() -> String {
        return "sin(" + argument.toString() + ")"
    }
    
    public func toLaTeX() -> String {
        return "\\sin{(" + argument.toLaTeX() + ")}"
    }
}

extension Sin: Equatable {
    public static func == (lhs: Sin, rhs: Sin) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument)
    }
}
