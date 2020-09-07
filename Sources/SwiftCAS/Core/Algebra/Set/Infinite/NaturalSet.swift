//
//  NaturalSet.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

public class NaturalSet: InfiniteSet {
    public let symbol: String = "ℕ"
    
    public required init() {}
    
    public var canonicalBasis = FiniteSet(Vector(1))
    
    public func contains(_ node: Node) -> Bool {
        if let node = node as? Int, node.isNatural() {
            return true
        }
        return false
    }
}

extension NaturalSet: Equatable {
    public static func ==(lhs: NaturalSet, rhs: NaturalSet) -> Bool {
        return true
    }
}
