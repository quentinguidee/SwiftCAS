//
//  TokenDefinition.swift
//  
//
//  Created by Quentin Guidée on 27/07/2020.
//

public protocol TokenDefinition {
    var token: String { get }
    var build: ([Any]) -> Any { get }
}

public struct OpeningBracketDefinition: TokenDefinition {
    public var token: String
    public var build: ([Any]) -> Any = { args in "" }
    
    public init(_ token: String) {
        self.token = token
    }
}

public struct ClosingBracketDefinition: TokenDefinition {
    public var token: String
    public var build: ([Any]) -> Any = { args in "" }
    
    public init(_ token: String) {
        self.token = token
    }
}

public struct OperatorDefinition: TokenDefinition {
    public var token: String
    public var build: ([Any]) -> Any
    
    // TODO: Remove all inits ?
    public init(_ token: String, _ build: @escaping ([Any]) -> Any) {
        self.token = token
        self.build = build
    }
}

public struct CommandDefinition: TokenDefinition {
    public var token: String
    public var nArgs: Int
    public var build: ([Any]) -> Any
    
    public init(_ token: String, _ nArgs: Int, _ build: @escaping ([Any]) -> Any) {
        self.token = token
        self.nArgs = nArgs
        self.build = build
    }
}

public struct PrefixDefinition: TokenDefinition {
    public var token: String
    public var build: ([Any]) -> Any
    
    public init(_ token: String, _ build: @escaping ([Any]) -> Any) {
        self.token = token
        self.build = build
    }
}

public struct PostfixDefinition: TokenDefinition {
    public var token: String
    public var build: ([Any]) -> Any
    
    public init(_ token: String, _ build: @escaping ([Any]) -> Any) {
        self.token = token
        self.build = build
    }
}

public struct NumberDefinition: TokenDefinition {
    public var token: String
    public var build: ([Any]) -> Any
    
    public init(_ token: String, _ build: @escaping ([Any]) -> Any) {
        self.token = token
        self.build = build
    }
}

public struct UnknownDefinition: TokenDefinition {
    public var token: String
    public var build: ([Any]) -> Any
    
    public init(_ token: String, _ build: @escaping ([Any]) -> Any) {
        self.token = token
        self.build = build
    }
}
