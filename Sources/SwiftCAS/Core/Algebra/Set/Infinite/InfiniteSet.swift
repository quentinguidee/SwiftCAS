//
//  InfiniteSet.swift
//  
//
//  Created by Quentin Guidée on 06/09/2020.
//

import Foundation

public protocol InfiniteSet: Set {
    var symbol: String { get }
    var canonicalBasis: FiniteSet { get }
    init()
}

extension InfiniteSet {
    public var dimension: Int { return canonicalBasis.dimension }
    
    public func shallowCopy() -> Self {
        return Self()
    }
    
    public func toString() -> String {
        return symbol
    }
    
    public func toLaTeX() -> String {
        // TODO: Return LaTeX symbol
        return toString()
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.symbol == rhs.symbol
    }
}
