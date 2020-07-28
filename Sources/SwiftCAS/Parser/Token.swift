//
//  Token.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

public struct Token: CustomStringConvertible {
    public static let tokenDefinitions: [[TokenDefinition]] = [
        TokensLibrary.openingBrackets,
        TokensLibrary.closingBrackets,
        TokensLibrary.operators,
        TokensLibrary.constants,
        TokensLibrary.commands,
        TokensLibrary.prefixes,
        TokensLibrary.postfixes,
        TokensLibrary.separators
    ]
    
    public var tokenDefinition: TokenDefinition
    
    public private(set) var value: String
    
    public var description: String {
        return "(" + String(describing: tokenDefinition) + ", \"" + value + "\")"
    }
    
    public init(_ tokenDefinition: TokenDefinition, _ value: String) {
        self.tokenDefinition = tokenDefinition
        self.value = value
    }
    
    public func build(_ nodes: Any...) -> Any {
        return tokenDefinition.build(nodes)
    }
    
    public static func getDefinition(of element: String) -> TokenDefinition {
        if element.contains(".") {
            return TokensLibrary.real
        } else if element.isNumeric {
            return TokensLibrary.integer
        }
        
        for subTokenDefinitions in tokenDefinitions {
            for tokenDefinition in subTokenDefinitions {
                if tokenDefinition.token == element { return tokenDefinition }
            }
        }
        
        return TokensLibrary.unknown
    }
}
