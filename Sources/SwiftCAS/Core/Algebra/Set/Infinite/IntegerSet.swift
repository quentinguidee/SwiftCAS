//
//  IntegerSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

public class IntegerSet: InfiniteSet {
    public let symbol: String = "ℤ"
    
    public required init() {}
    
    public var canonicalBasis = FiniteSet(
        Vector(1)
    )
    
    public func contains(_ node: Node) -> Bool {
        return node is Int
    }
}

extension IntegerSet: Equatable {
    public static func ==(lhs: IntegerSet, rhs: IntegerSet) -> Bool {
        return true
    }
}
