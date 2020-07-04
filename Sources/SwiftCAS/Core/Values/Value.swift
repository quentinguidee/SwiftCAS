//
//  Value.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

protocol Value: Node {}

extension Value {
    func differentiate(of unknown: Unknown) -> Node {
        return 0
    }
    
    func integrate(of unknown: Unknown) -> Node {
        return Multiplication(self, unknown)
    }
    
    func simplify() -> Node {
        return self
    }
}
