//
//  Double.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

extension Double: NumericalValue {
    func toDouble() -> Double {
        return self
    }
    
    func toString() -> String {
        return String(self)
    }
    
    func toLaTeX() -> String {
        return toString()
    }
    
    func opposite() -> Node {
        return -self
    }
}
