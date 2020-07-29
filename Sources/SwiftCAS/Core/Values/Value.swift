//
//  Value.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

public protocol Value: Node {}

extension Value {
    public func simplified() -> Node {
        return self
    }
}
