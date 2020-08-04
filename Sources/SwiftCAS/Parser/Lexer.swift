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
        
        handleImplicitTokens(&array)
        
        return array
    }
    
    static func handleImplicitTokens(_ expression: inout [Token]) {
        let implicitDefinitions = [
            (NumberDefinition.self, OpeningBracketDefinition.self), // 2(
            (UnknownDefinition.self, OpeningBracketDefinition.self), // x(
            (ConstantDefinition.self, OpeningBracketDefinition.self), // π(
            (ClosingBracketDefinition.self, NumberDefinition.self), // )2
            (ClosingBracketDefinition.self, UnknownDefinition.self), // )x
            (ClosingBracketDefinition.self, ConstantDefinition.self), // )π
            (ClosingBracketDefinition.self, OpeningBracketDefinition.self), // )(
            (NumberDefinition.self, UnknownDefinition.self), // 2x
            (UnknownDefinition.self, NumberDefinition.self), // x2
            (NumberDefinition.self, ConstantDefinition.self), // 2π
            (ConstantDefinition.self, NumberDefinition.self), // π2
        ] as [(TokenDefinition.Type, TokenDefinition.Type)]
        
        var i = 0
        while (i+1) < expression.count {
            for definition in implicitDefinitions {
                if type(of: expression[i].tokenDefinition) == definition.0 && type(of: expression[i+1].tokenDefinition) == definition.1 {
                    expression.insert(Token(Token.getDefinition(of: "*"), "*"), at: i+1)
                }
            }
            i += 1
        }
    }
}
