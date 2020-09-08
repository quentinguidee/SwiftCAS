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

extension Unknown: Differentiable {
    public func differentiated(of unknown: Unknown) -> Node {
        return symbol == unknown.symbol ? 1 : 0
    }
}

extension Unknown: Integrable {
    public func integrated(of unknown: Unknown) -> Node {
        if symbol == unknown.symbol {
            return Division(Pow(self, 2), 2)
        } else {
            return Multiplication(self, unknown)
        }
    }
}

extension Unknown: Equatable {
    public static func == (lhs: Unknown, rhs: Unknown) -> Bool {
        return lhs.symbol == rhs.symbol
    }
}
