//
//  Lexer.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

import Foundation

public class Lexer {
    public static let openingBrackets = ["(", "{", "["]
    public static let closingBrackets = [")", "}", "]"]
    
    public static func tokenized(_ expression: String) -> [Token] {
        var array: [Token] = []
        var latestTokenType: TokenType = .None
        var currentElement = ""
        
        for char in expression {
            let tokenType = getTokenType(of: String(char))
            
            if currentElement == "" {
                currentElement = String(char)
                latestTokenType = tokenType
            } else if (latestTokenType == .IntNumber && tokenType == .DoubleNumber) || (latestTokenType == .DoubleNumber && tokenType == .IntNumber) {
                latestTokenType = .DoubleNumber
                currentElement.append(char)
            } else if tokenType != latestTokenType || latestTokenType == .OpeningBrackets || latestTokenType == .ClosingBrackets {
                array.append(Token(latestTokenType, currentElement))
                currentElement = String(char)
                latestTokenType = tokenType
            } else {
                currentElement.append(char)
            }
        }
        
        array.append(Token(latestTokenType, currentElement))
        
        return array
    }
    
    public static func getTokenType(of element: String) -> TokenType {
        switch element {
            case let e where e.isNumeric: return .IntNumber
            case let e where e.isOpeningBrackets: return .OpeningBrackets
            case let e where e.isClosingBrackets: return .ClosingBrackets
            case ".": return .DoubleNumber
            case "^": return .PowOperator
            case "*": return .MultiplicationOperator
            case "/": return .DivisionOperator
            case "+": return .AdditionOperator
            case "-": return .SubstractionOperator
            default: return .UnknownSymbol
        }
    }
}

extension String {
    public var isNumeric: Bool {
        return Double(self) != nil
    }
    
    public var isOpeningBrackets: Bool {
        return Lexer.openingBrackets.contains(self)
    }
    
    public var isClosingBrackets: Bool {
        return Lexer.closingBrackets.contains(self)
    }
}
