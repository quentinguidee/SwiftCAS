//
//  Set.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

public protocol Set {
    var dimension: Int { get }
    
    func contains(_ node: Node) -> Bool
}

public struct Sets {
    public static let real = RealSet()
    public static let integer = IntegerSet()
    public static let natural = NaturalSet()
    public static let complex = ComplexSet()
}
