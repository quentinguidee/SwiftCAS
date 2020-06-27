//
//  File.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Infinity: SymbolicValue {
    var symbol: String = "∞"
    
    func toLaTeX() -> String { return "\\infty" }
}
