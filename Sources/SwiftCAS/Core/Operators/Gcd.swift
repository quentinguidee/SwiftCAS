//
//  Gcd.swift
//  
//
//  Created by Quentin Guidée on 30/07/2020.
//

public class Gcd: Operator{
    var a, b: Node
    public var sign: Sign { .Positive }
    
    public required init(_ a: Node, _ b: Node) {
        self.a = a
        self.b = b
    }
    
    public func simplified() -> Node {
        if let a = a as? Int, let b = b as? Int {
            return gcd(a, b)
        }
        return Gcd(a, b)
    }
    
    public func toString() -> String {
        return "gcd(\(a.toString()), \(b.toString()))"
    }
    
    public func toLaTeX() -> String {
        return "gcd(\(a.toLaTeX()), \(b.toLaTeX()))"
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