//
//  Int.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

extension Int: NumericalValue {
    public func toDouble() -> Double {
        return Double(self)
    }
    
    public func toString() -> String {
        return String(self)
    }
    
    public func toLaTeX() -> String {
        return toString()
    }
    
    public func isNatural() -> Bool {
        return self >= 0
    }
    
    public func isEven() -> Bool {
        return self.absoluteValue() as! Int % 2 == 0
    }
    
    public func isOdd() -> Bool {
        return self.absoluteValue() as! Int % 2 == 1
    }
}
