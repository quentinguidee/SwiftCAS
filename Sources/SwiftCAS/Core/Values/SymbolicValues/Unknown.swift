//
//  Unknown.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

class Unknown: SymbolicValue {
    var symbol: String
    var sign: Sign { return .Unknown }
    
    init() {
        self.symbol = "x"
    }
    
    init(_ symbol: String) {
        self.symbol = symbol
    }
    
    func integrate(of unknown: Unknown) -> Node {
        if symbol == unknown.symbol {
            return Division(Pow(self, 2), 2)
        } else {
            return Multiplication(self, unknown)
        }
    }
}
