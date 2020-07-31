//
//  Int.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

extension Int: NumericalValue {
    public func shallowCopy() -> Node {
        return self
    }
    
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
    
    public func factorize() -> [Int] {
        var value = self.absoluteValue() as! Int
        if value >= 0 && value <= 2 { return [self] }
        
        var nodes: [Int] = []
        var i = 2
        while i <= value {
            if value % i == 0 {
                value /= i
                nodes.append(i)
            } else {
                i += 1
            }
        }
        
        return nodes
    }
}
