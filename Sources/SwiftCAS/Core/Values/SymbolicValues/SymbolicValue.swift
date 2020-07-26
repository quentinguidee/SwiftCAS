//
//  SymbolicValue.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public protocol SymbolicValue: Value {
    var symbol: String { get set }
}

extension SymbolicValue {
    public func toString() -> String { return symbol }
    public func toLaTeX() -> String { return symbol }
}
