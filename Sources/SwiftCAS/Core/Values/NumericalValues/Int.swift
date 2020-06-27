//
//  Int.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

extension Int: NumericalValue {
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
