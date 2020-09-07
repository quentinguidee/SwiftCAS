//
//  Union.swift
//  
//
//  Created by Quentin Guidée on 06/09/2020.
//

public class Union: Node {
    public var A: Set
    public var B: Set
    
    public var sign: Sign = .Positive
    
    public required init(_ A: Set, _ B: Set) {
        self.A = A
        self.B = B
    }
    
    public func shallowCopy() -> Self {
        return Self(A, B)
    }
    
    public func simplified() -> Node {
        return A.union(with: B)
    }
    
    public func prettified() -> Node {
        return shallowCopy()
    }
    
    public func toString() -> String {
        return A.toString() + "∪" + B.toString()
    }
    
    public func toLaTeX() -> String {
        return A.toLaTeX() + "\\cup" + B.toLaTeX()
    }
}

extension Union: Equatable {
    public static func ==(lhs: Union, rhs: Union) -> Bool {
        return lhs.A.isEqualTo(rhs.A)
    }
}

public protocol Unionable {
    func union(with set: Set) -> Node
    func union(with set: InfiniteSet) -> Node
    func union(with set: FiniteSet) -> Node
}

// TODO: Remove this if possible
extension Unionable {
    public func union(with set: Set) -> Node {
        switch set {
            case let s as InfiniteSet:
                return union(with: s)
            case let s as FiniteSet:
                return union(with: s)
            default:
                fatalError("Cannot make an union with this Set.")
        }
    }
}

extension FiniteSet: Unionable {
    public func union(with set: InfiniteSet) -> Node {
        let newFiniteSet = shallowCopy()
        for vector in vectors {
            if set.contains(vector) {
                newFiniteSet.remove(vector: vector)
            }
        }
        
        if newFiniteSet.dimension == 0 {
            return set
        } else {
            return Union(set.shallowCopy(), newFiniteSet)
        }
    }
    
    public func union(with set: FiniteSet) -> Node {
        let newSet = shallowCopy()
        newSet.add(vectors: set.vectors)
        return newSet
    }
}

extension InfiniteSet {
    public func union(with set: InfiniteSet) -> Node {
        // TODO: Implement this
        if symbol == set.symbol { return shallowCopy() }
        return Union(shallowCopy(), set)
    }
    
    public func union(with set: FiniteSet) -> Node {
        return set.union(with: self)
    }
}
