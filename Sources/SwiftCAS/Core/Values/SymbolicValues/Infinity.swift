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
    
    public func shallowCopy() -> Node {
        return Infinity()
    }
    
    public func toLaTeX() -> String {
        return "\\infty"
    }
}
