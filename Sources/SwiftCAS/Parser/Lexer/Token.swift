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
    case Symbol
    case None
}

public enum TokenType {
    case IntNumber, DoubleNumber
    case AdditionOperator, SubstractionOperator, DivisionOperator, MultiplicationOperator, PowOperator
    case OpeningBrackets, ClosingBrackets
    case UnknownSymbol
    case None
    
    public func getCategory() -> TokenCategory {
        switch self {
            case .IntNumber, .DoubleNumber:
                return .Number
            case .AdditionOperator, .SubstractionOperator, .DivisionOperator, .MultiplicationOperator, .PowOperator:
                return .Operator
            case .OpeningBrackets, .ClosingBrackets:
                return .Brackets
            case .UnknownSymbol:
                return .Symbol
            case .None:
                return .None
        }
    }
    
    func createNode(_ args: [Any]) -> Node {
        switch self {
            case .PowOperator:
                return Pow(args[0] as! Node, args[1] as! Node)
            case .MultiplicationOperator:
                return Multiplication(args[0] as! Node, args[1] as! Node)
            case .DivisionOperator:
                return Division(args[0] as! Node, args[1] as! Node)
            case .AdditionOperator:
                return Addition(args[0] as! Node, args[1] as! Node)
            case .SubstractionOperator:
                return Addition(args[0] as! Node, Opposite(args[1] as! Node))
            case .IntNumber:
                return Int(args[0] as! String)!
            case .DoubleNumber:
                return Double(args[0] as! String)!
            case .UnknownSymbol:
                return Unknown(args[0] as! String)
            default:
                fatalError()
        }
    }
}

public struct Token: CustomStringConvertible {
    public var type: TokenType
    public var category: TokenCategory { return type.getCategory() }
    
    public private(set) var value: String
    
    public var description: String {
        return "(" + String(describing: type) + ", \"" + value + "\")"
    }
    
    public init(_ type: TokenType, _ value: String) {
        self.type = type
        self.value = value
    }
    
    public func build(_ nodes: Any...) -> Node {
        return type.createNode(nodes)
    }
}
