//
//  Value.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

protocol Value: Node {}

extension Value {
    func integrate(of unknown: Unknown) -> Node {
        return Multiplication(self, unknown)
    }
}
