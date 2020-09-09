//
//  SignNode.swift
//  
//
//  Created by Quentin Guidée on 28/07/2020.
//

public class SignNode: Node {
    public private(set) var argument: Node
    public var sign: Sign { return argument.sign }
    
    public required init(_ argument: Node) {
        self.argument = argument
    }
    
    public func shallowCopy() -> Self {
        return Self(argument)
    }
    
    public func simplified() -> Node {
        return sign == .Unknown ? shallowCopy() : sign.rawValue
    }
    
    public func prettified() -> Node {
        return SignNode(argument.prettified())
    }
    
    public func toString() -> String {
        return "sign(\(argument.toString()))"
    }
    
    public func toLaTeX() -> String {
        return "sign(\(argument.toLaTeX()))"
    }
}

extension SignNode: Equatable {
    public static func == (lhs: SignNode, rhs: SignNode) -> Bool {
        return lhs.argument.isEqualTo(rhs.argument)
    }
}
