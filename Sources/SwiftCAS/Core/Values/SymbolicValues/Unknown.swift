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
}
