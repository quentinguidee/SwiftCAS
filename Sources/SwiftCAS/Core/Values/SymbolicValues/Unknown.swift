//
//  Unknown.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

public class Unknown: SymbolicValue {
    public let symbol: String
    public var sign: Sign { return .Unknown }
    
    public init() {
        self.symbol = "x"
    }
    
    public required init(_ symbol: String) {
        self.symbol = symbol
    }
    
    public func shallowCopy() -> Self {
        return Self(symbol)
    }
}
