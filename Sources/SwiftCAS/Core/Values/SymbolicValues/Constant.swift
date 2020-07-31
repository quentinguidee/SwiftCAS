//
//  Constant.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

import Foundation

public class Constant: SymbolicValue {
    public var symbol: String
    public var sign: Sign {
        switch self {
            case let x where x.toDouble() < 0:
                return .Negative
            case let x where x.toDouble() > 0:
                return .Positive
            default:
                return .Signless
        }
    }
    
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
    
    public required init(_ symbol: String) {
        self.symbol = symbol
    }
    
    public func shallowCopy() -> Self {
        return Self(symbol)
    }
    
    public func toDouble() -> Double {
        if let double = Constant.constants[symbol] { return double }
        fatalError("The constant \(symbol) doesn't exist")
    }
    
    public func toLaTeX() -> String {
        if let latexCode = Constant.constantsInLatexCode[symbol] { return latexCode }
        return toString()
    }
}
