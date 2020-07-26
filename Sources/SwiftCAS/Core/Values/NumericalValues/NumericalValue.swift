//
//  NumericalValue.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public protocol NumericalValue: Value {
    func toDouble() -> Double
    func isNull() -> Bool
}

extension NumericalValue {
    public var sign: Sign {
        switch self {
            case let x where x.toDouble() < 0:
                return .Negative
            case let x where x.toDouble() > 0:
                return .Positive
            default:
                return .Signless
        }
    }
    
    public func isNull() -> Bool {
        return toDouble() == 0
    }
}
