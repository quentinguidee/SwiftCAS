//
//  Value.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

protocol Value: Node {}

extension Value {
    func simplify() -> Node {
        return self
    }
}
