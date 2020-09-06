//
//  ComplexSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

public class ComplexSet: InfiniteSet {
    public let symbol: String = "ℂ"
    
    public required init() {}
    
    public var canonicalBasis = FiniteSet(
        Vector(1),
        Vector(Complex(0, 1))
    )
    
    public func contains(_ node: Node) -> Bool {
        return node is Complex || Sets.real.contains(node)
    }
}

extension ComplexSet: Equatable {
    public static func ==(lhs: ComplexSet, rhs: ComplexSet) -> Bool {
        return true
    }
}
