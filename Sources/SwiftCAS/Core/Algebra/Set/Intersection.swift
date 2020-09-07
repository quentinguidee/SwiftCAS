//
//  Intersection.swift
//  
//
//  Created by Quentin Guidée on 07/09/2020.
//

public class Intersection: Node {
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
        return A.intersection(with: B)
    }
    
    public func prettified() -> Node {
        return shallowCopy()
    }
    
    public func toString() -> String {
        return A.toString() + "∩" + B.toString()
    }
    
    public func toLaTeX() -> String {
        return A.toLaTeX() + "\\cap" + B.toLaTeX()
    }
}

extension Intersection: Equatable {
    public static func ==(lhs: Intersection, rhs: Intersection) -> Bool {
        return lhs.A.isEqualTo(rhs.A)
    }
}

public protocol Intersectable {
    func intersection(with set: Set) -> Node
    func intersection(with set: InfiniteSet) -> Node
    func intersection(with set: FiniteSet) -> Node
}

// TODO: Remove this if possible
extension Intersectable {
    public func intersection(with set: Set) -> Node {
        switch set {
            case let s as InfiniteSet:
                return intersection(with: s)
            case let s as FiniteSet:
                return intersection(with: s)
            default:
                fatalError("Cannot make an union with this Set.")
        }
    }
}

extension FiniteSet: Intersectable {
    public func intersection(with set: InfiniteSet) -> Node {
        let newSet = shallowCopy()
        newSet.removeAll { vector in
            !set.contains(vector)
        }
        return newSet
    }
    
    public func intersection(with set: FiniteSet) -> Node {
        let newSet = shallowCopy()
        newSet.removeAll { vector in
            !set.contains(vector)
        }
        return newSet
    }
}

extension InfiniteSet {
    public func intersection(with set: InfiniteSet) -> Node {
        // TODO: Implement this
        if symbol == set.symbol { return shallowCopy() }
        return Intersection(shallowCopy(), set)
    }
    
    public func intersection(with set: FiniteSet) -> Node {
        return set.intersection(with: self)
    }
}
