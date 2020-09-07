//
//  Set.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

public protocol Set: Node, Unionable, Intersectable {
    var dimension: Int { get }
    
    func contains(_ node: Node) -> Bool
}

extension Set {
    public var sign: Sign { return .Positive }
    
    public func simplified() -> Node {
        return shallowCopy()
    }
    
    public func prettified() -> Node {
        return shallowCopy()
    }
}

public struct Sets {
    public static let real = RealSet()
    public static let integer = IntegerSet()
    public static let natural = NaturalSet()
    public static let complex = ComplexSet()
}
