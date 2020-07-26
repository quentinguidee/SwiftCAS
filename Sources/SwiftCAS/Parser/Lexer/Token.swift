//
//  Token.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

public enum TokenCategory {
    case Number
    case Operator
    case Brackets
    case Unknown
    case None
}

public enum TokenType {
    case Int, Double
    case AdditionOperator, SubstractionOperator, DivisionOperator, MultiplicationOperator, PowOperator
    case OpeningBrackets, ClosingBrackets
    case Unknown
    case None
    
    public func getCategory() -> TokenCategory {
        switch self {
            case .Int, .Double:
                return .Number
            case .AdditionOperator, .SubstractionOperator, .DivisionOperator, .MultiplicationOperator, .PowOperator:
                return .Operator
            case .OpeningBrackets, .ClosingBrackets:
                return .Brackets
            case .Unknown:
                return .Unknown
            case .None:
                return .None
        }
    }
    
    func createNode(_ nodes: [Node]) -> Node {
        switch self {
            case .PowOperator:
                return Pow(nodes[0], nodes[1])
            case .MultiplicationOperator:
                return Multiplication(nodes[0], nodes[1])
            case .DivisionOperator:
                return Division(nodes[0], nodes[1])
            case .AdditionOperator:
                return Addition(nodes[0], nodes[1])
            default:
                fatalError()
        }
    }
}

public struct Token: CustomStringConvertible {
    public private(set) var type: TokenType
    public var category: TokenCategory { return type.getCategory() }
    
    public private(set) var value: String
    
    public var description: String {
        return "(" + String(describing: type) + ", \"" + value + "\")"
    }
    
    public init(_ type: TokenType, _ value: String) {
        self.type = type
        self.value = value
    }
    
    public func build(_ nodes: Node...) -> Node {
        return type.createNode(nodes)
    }
}
