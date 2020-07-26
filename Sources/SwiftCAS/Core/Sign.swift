//
//  Sign.swift
//  
//
//  Created by Quentin Guidée on 01/07/2020.
//

public enum Sign: Int {
    case Negative = -1
    case Signless = 0
    case Positive = 1
    case Unknown = 2
    
    var description: String {
        switch self {
            case .Negative:
                return "-"
            case .Positive:
                return "+"
            case .Unknown:
                return "?"
            default:
                return "0"
        }
    }
}
