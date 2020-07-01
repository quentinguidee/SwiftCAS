//
//  Int.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

extension Int: NumericalValue {
    func toDouble() -> Double {
        return Double(self)
    }
    
    func toString() -> String {
        return String(self)
    }
    
    func toLaTeX() -> String {
        return toString()
    }
    
    func isNatural() -> Bool {
        return self >= 0
    }
}
