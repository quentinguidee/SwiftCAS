//
//  Int.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

extension Int: NumericalValue {
    func isNull() -> Bool {
        return self == 0
    }
    
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
    
    public func isEven() -> Bool {
        return self.absoluteValue() as! Int % 2 == 0
    }
    
    public func isOdd() -> Bool {
        return self.absoluteValue() as! Int % 2 == 1
    }
    
    func opposite() -> Node {
        return -self
    }
}
