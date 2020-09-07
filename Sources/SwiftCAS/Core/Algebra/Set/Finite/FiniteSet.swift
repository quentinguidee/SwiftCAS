//
//  FiniteSet.swift
//  
//
//  Created by Quentin Guidée on 06/09/2020.
//

import Foundation

public typealias EmptySet = FiniteSet

public class FiniteSet: Set {
    public private(set) var vectors: [Node] = []
    public var dimension: Int { return vectors.count }
    
    public init() {}
    
    public required init(vectors: [Node]) {
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
    
    public func remove(vector: Node) {
        vectors.removeAll { $0.isEqualTo(vector) }
    }
    
    public func remove(vectors: [Node]) {
        self.vectors.removeAll { v in vectors.contains { $0.isEqualTo(v) } }
    }
    
    public func removeAll(where shouldBeRemoved: (Node) throws -> Bool) rethrows {
        try vectors.removeAll(where: shouldBeRemoved)
    }
    
    public func remove(vectors: Node...) {
        remove(vectors: vectors)
    }
    
    public func contains(_ node: Node) -> Bool {
        return self.vectors.contains { $0.isEqualTo(node) }
    }
}

extension FiniteSet {
    public func shallowCopy() -> Self {
        return Self(vectors: vectors)
    }
    
    public func toString() -> String {
        var s: String
        s = vectors.map({ $0.toString() }).joined(separator: ",")
        return "{\(s)}"
    }
    
    public func toLaTeX() -> String {
        var s: String
        s = vectors.map({ $0.toLaTeX() }).joined(separator: ",")
        return "\\left\\{\(s)\\Right\\}"
    }
}

extension FiniteSet: Equatable {
    public static func ==(lhs: FiniteSet, rhs: FiniteSet) -> Bool {
        guard lhs.vectors.count == rhs.vectors.count else { return false }
        
        let lhsChildren = lhs.vectors
        var rhsChildren = rhs.vectors
        
        for node in lhsChildren {
            let i = rhsChildren.firstIndex(where: { $0.isEqualTo(node)}) ?? -1
            if i != -1 { rhsChildren.remove(at: i) }
        }
        
        return rhsChildren.isEmpty
    }
}
