//
//  Lexer.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

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
            } else if (latestTokenDefinition?.token == TokensLibrary.integer.token && tokenDefinition.token == TokensLibrary.real.token)
                   || (latestTokenDefinition?.token == TokensLibrary.real.token && tokenDefinition.token == TokensLibrary.integer.token) {
                latestTokenDefinition = TokensLibrary.real
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
