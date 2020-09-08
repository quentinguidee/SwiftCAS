//
//  Infinity.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public class Infinity: SymbolicValue {
    static let symbol: String = "∞"
    public var symbol: String = "∞"
    public var sign: Sign { return .Positive }
    
    required init() {}
    
    public func shallowCopy() -> Self {
        return Self()
    }
    
    public func toLaTeX() -> String {
        return "\\infty"
    }
}

extension Infinity: Integrable {
    public func integrated(of unknown: Unknown) -> Node {
        return self
    }
}

extension Infinity: Equatable {
    public static func == (lhs: Infinity, rhs: Infinity) -> Bool {
        return true
    }
}
