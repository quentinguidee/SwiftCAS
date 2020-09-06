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
}

extension InfiniteSet {
    public var dimension: Int { return canonicalBasis.dimension }
}
