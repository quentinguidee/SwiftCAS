//
//  Infinity.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Infinity: SymbolicValue {
    var symbol: String = "∞"
    var sign: Sign { return .Positive }
    
    func toLaTeX() -> String { return "\\infty" }
    
    func absoluteValue() -> Node { return self }
    
    func integrate(of unknown: Unknown) -> Node {
        return self
    }
}
