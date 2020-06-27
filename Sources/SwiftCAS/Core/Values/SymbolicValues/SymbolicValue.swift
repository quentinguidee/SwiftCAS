//
//  SymbolicValue.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol SymbolicValue: Node {
    var symbol: String { get set }
}

extension SymbolicValue {
    func toString() -> String { return symbol }
    func toLaTeX() -> String { return symbol }
}
