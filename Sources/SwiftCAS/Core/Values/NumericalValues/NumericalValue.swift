//
//  NumericalValue.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol NumericalValue: Node {
    func toDouble() -> Double
    func isNull() -> Bool
}

extension NumericalValue {
    var sign: Sign {
        switch self {
            case let x where x.toDouble() < 0:
                return .Negative
            case let x where x.toDouble() > 0:
                return .Positive
            default:
                return .Signless
        }
    }
}
