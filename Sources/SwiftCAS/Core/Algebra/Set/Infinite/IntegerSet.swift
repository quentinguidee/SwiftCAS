//
//  IntegerSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

public struct IntegerSet: InfiniteSet {
    public let symbol: String = "ℤ"
    
    public var canonicalBasis = FiniteSet(
        Vector(1)
    )
    
    public func contains(_ node: Node) -> Bool {
        return node is Int
    }
}
