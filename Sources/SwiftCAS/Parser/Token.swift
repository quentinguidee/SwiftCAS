//
//  Token.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

public struct Token: CustomStringConvertible {
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
        guard tokenDefinition is Buildable else { fatalError("Trying to build a non buildable token") }
        return (tokenDefinition as! Buildable).build(nodes)
    }
    
    public static func getDefinition(of element: String) -> TokenDefinition {
        if element.contains(".") {
            return TokensLibrary.real
        } else if element.isNumeric && element != "inf" && element != "infinity" {
            return TokensLibrary.integer
        }
        
        for subTokenDefinitions in TokensLibrary.allDefinitions {
            for tokenDefinition in subTokenDefinitions {
                if tokenDefinition.token == element { return tokenDefinition }
            }
        }
        
        return TokensLibrary.unknown
    }
}
