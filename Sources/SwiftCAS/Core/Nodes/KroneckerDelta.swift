//
//  KroneckerDelta.swift
//  
//
//  Created by Quentin Guidée on 04/08/2020.
//

class KroneckerDelta: Node {
    public private(set) var i, j: Node
    
    public var sign: Sign { simplified().sign }
    
    public required init(_ i: Node, _ j: Node) {
        self.i = i
        self.j = j
    }
    
    public func shallowCopy() -> Self {
        Self(i, j)
    }
    
    public func simplified() -> Node {
        return i.isEqualTo(j) ? 1 : 0
    }
    
    public func prettified() -> Node {
        return KroneckerDelta(i.prettified(), j.prettified())
    }
    
    public func toString() -> String {
        return "δ_(\(i.toString())\(j.toString()))"
    }
    
    public func toLaTeX() -> String {
        return "\\delta_{\(i.toLaTeX())\(j.toLaTeX())}"
    }
}

extension KroneckerDelta: Equatable {
    public static func == (lhs: KroneckerDelta, rhs: KroneckerDelta) -> Bool {
        return lhs.simplified().isEqualTo(rhs.simplified())
    }
}
