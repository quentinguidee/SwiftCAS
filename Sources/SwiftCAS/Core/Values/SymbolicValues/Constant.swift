//
//  Constant.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

import Foundation

class Constant: SymbolicValue {
    var symbol: String
    
    static let π = Double.pi
    static let e = M_E
    
    static let constants = [
        "π": π,
        "pi": π,
        "e": e
    ]
    
    static let constantsInLatexCode = [
        "π": "\\pi",
        "pi": "\\pi"
    ]
    
    init(_ symbol: String) {
        self.symbol = symbol
    }
    
    func toDouble() -> Double {
        if let double = Constant.constants[symbol] { return double }
        fatalError("The constant \(symbol) doesn't exist")
    }
    
    func toLaTeX() -> String {
        if let latexCode = Constant.constantsInLatexCode[symbol] { return latexCode }
        return toString()
    }
}
