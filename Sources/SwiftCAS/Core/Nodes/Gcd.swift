//
//  Gcd.swift
//  
//
//  Created by Quentin Guidée on 30/07/2020.
//

public class Gcd: Node {
    public private(set) var a, b: Node
    public var sign: Sign { .Positive }
    
    public required init(_ a: Node, _ b: Node) {
        self.a = a
        self.b = b
    }
    
    public func shallowCopy() -> Self {
        Self(a, b)
    }
    
    public func simplified() -> Node {
        if let a = a as? Int, let b = b as? Int {
            return gcd(a, b)
        }
        return shallowCopy()
    }
    
    public func prettified() -> Node {
        return Gcd(a.prettified(), b.prettified())
    }
    
    public func toString() -> String {
        return "gcd(\(a.toString()), \(b.toString()))"
    }
    
    public func toLaTeX() -> String {
        return "gcd(\(a.toLaTeX()), \(b.toLaTeX()))"
    }
}

extension Gcd: Equatable {
    public static func == (lhs: Gcd, rhs: Gcd) -> Bool {
        return lhs.a.isEqualTo(rhs.a) && lhs.b.isEqualTo(rhs.b)
    }
}

public func gcd(_ a: Int, _ b: Int) -> Node {
    var A = a
    var B = b
    while B != 0 {
        let rest = A % B
        A = B
        B = rest
    }
    return A.absoluteValue()
}
