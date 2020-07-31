//
//  Double.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

import Foundation

extension Double: NumericalValue {
    public func shallowCopy() -> Self {
        return self
    }
    
    public func toDouble() -> Double {
        return self
    }
    
    public func toString() -> String {
        return String(self)
    }
    
    public func toLaTeX() -> String {
        return toString()
    }
    
    public func toIntIfPossible() -> Node {
        return self == floor(self) ? Int(self) : self
    }
}
