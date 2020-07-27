//
//  Lexer.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

import Foundation

public class Lexer {
    public static func tokenized(_ expression: String) -> [Token] {
        var array: [Token] = []
        var latestTokenDefinition: TokenDefinition? = nil
        var currentElement = ""
        
        for char in expression {
            let tokenDefinition = Token.getDefinition(of: String(char))
            
            if currentElement == "" {
                currentElement = String(char)
                latestTokenDefinition = tokenDefinition
            } else if (latestTokenDefinition?.token == Token.integer.token && tokenDefinition.token == Token.real.token)
                   || (latestTokenDefinition?.token == Token.real.token && tokenDefinition.token == Token.integer.token) {
                latestTokenDefinition = Token.real
                currentElement.append(char)
            } else if tokenDefinition.token != latestTokenDefinition?.token
                   || latestTokenDefinition is OpeningBracketDefinition
                   || latestTokenDefinition is ClosingBracketDefinition {
                array.append(Token(Token.getDefinition(of: currentElement), currentElement))
                currentElement = String(char)
                latestTokenDefinition = tokenDefinition
            } else {
                currentElement.append(char)
            }
        }
        
        array.append(Token(Token.getDefinition(of: currentElement), currentElement))
        
        return array
    }
}

extension String {
    public var isNumeric: Bool {
        return Double(self) != nil
    }
    
    public var isOpeningBrackets: Bool {
        return Token.openingBrackets.contains(where: { $0.token == self })
    }
    
    public var isClosingBrackets: Bool {
        return Token.closingBrackets.contains(where: { $0.token == self })
    }
}
