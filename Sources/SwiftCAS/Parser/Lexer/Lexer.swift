//
//  Lexer.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

public class Lexer {
    public static let operations = [["^"], ["*", "/"], ["+", "-"]]
    
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
        if element.isNumeric || element == "." {
            return .Double
        } else if element.isOpeningBrackets {
            return .OpeningBrackets
        } else if element.isClosingBrackets {
            return .ClosingBrackets
        }
        
        switch element {
            case "^": return .PowOperator
            case "*": return .MultiplicationOperator
            case "/": return .DivisionOperator
            case "+": return .AdditionOperator
            case "-": return .SubstractionOperator
            default: return .Unknown
        }
    }
}

extension String {
    public var isNumeric : Bool {
        return Double(self) != nil
    }
    
    public var isOpeningBrackets : Bool {
        return Lexer.openingBrackets.contains(self)
    }
    
    public var isClosingBrackets : Bool {
        return Lexer.closingBrackets.contains(self)
    }
    
    public var isBrackets : Bool {
        return isOpeningBrackets || isClosingBrackets
    }
}
