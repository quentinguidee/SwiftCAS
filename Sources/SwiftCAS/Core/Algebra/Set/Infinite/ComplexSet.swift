//
//  ComplexSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

public struct ComplexSet: InfiniteSet {
    public let symbol: String = "ℂ"
    
    public var canonicalBasis = FiniteSet(
        Vector(1),
        Vector(Complex(0, 1))
    )
    
    public func contains(_ node: Node) -> Bool {
        return node is Complex || Sets.real.contains(node)
    }
}
