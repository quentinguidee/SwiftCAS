//
//  File.swift
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
        if let A = A.shallowCopy() as? FiniteSet, let B = B.shallowCopy() as? FiniteSet {
            A.add(vectors: B.vectors)
            return A
        } else if A.isEqualTo(B) {
            return A.shallowCopy()
        }
        return shallowCopy()
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
