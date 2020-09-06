//
//  FiniteSet.swift
//  
//
//  Created by Quentin Guidée on 06/09/2020.
//

import Foundation

public class FiniteSet: Set {
    public private(set) var vectors: [Node] = []
    public var dimension: Int { return vectors.count }
    
    public init() {}
    
    public init(vectors: [Node]) {
        add(vectors: vectors)
    }
    
    public convenience init(_ vectors: Node...) {
        self.init(vectors: vectors)
    }
    
    public func add(vector: Node) {
        if contains(vector) { return }
        self.vectors.append(vector)
    }
    
    public func add(vectors: [Node]) {
        vectors.forEach { add(vector: $0) }
    }
    
    public func add(vectors: Node...) {
        add(vectors: vectors)
    }
    
    public func contains(_ node: Node) -> Bool {
        return self.vectors.contains { $0.isEqualTo(node) }
    }
}
