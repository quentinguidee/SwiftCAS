//
//  Value.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

public protocol Value: Node {}

extension Value {
    public func simplified() -> Node {
        return shallowCopy()
    }
    
    public func prettified() -> Node {
        return shallowCopy()
    }
}

extension Value {
    public func differentiated(of unknown: Unknown) -> Node {
        return 0
    }
}

extension Value {
    public func integrated(of unknown: Unknown) -> Node {
        return Multiplication(self, unknown)
    }
}
