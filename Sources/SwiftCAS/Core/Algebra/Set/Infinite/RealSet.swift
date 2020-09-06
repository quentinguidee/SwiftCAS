//
//  RealSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

public class RealSet: InfiniteSet {
    public let symbol: String = "ℝ"
    
    public required init() {}
    
    public var canonicalBasis = FiniteSet(Vector(1))
    
    public func contains(_ node: Node) -> Bool {
        return node is Double || Sets.integer.contains(node)
    }
}

extension RealSet: Equatable {
    public static func ==(lhs: RealSet, rhs: RealSet) -> Bool {
        return true
    }
}
