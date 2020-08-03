//
//  TokenDefinition.swift
//  
//
//  Created by Quentin Guidée on 27/07/2020.
//

public protocol TokenDefinition {
    var token: String { get }
}

public protocol Buildable {
    var build: ([Node]) -> Node { get }
}

public protocol BuildableFromString {
    var build: ([String]) -> Node { get }
}

public struct OpeningBracketDefinition: TokenDefinition {
    public var token: String
    
    public init(_ token: String) {
        self.token = token
    }
}

public struct ClosingBracketDefinition: TokenDefinition {
    public var token: String
    
    public init(_ token: String) {
        self.token = token
    }
}

public struct OperatorDefinition: TokenDefinition, Buildable {
    public var token: String
    public var build: ([Node]) -> Node
    
    // TODO: Remove all inits ?
    public init(_ token: String, _ build: @escaping ([Node]) -> Node) {
        self.token = token
        self.build = build
    }
}

public struct CommandDefinition: TokenDefinition, Buildable {
    public var token: String
    public var nArgs: Int
    public var build: ([Node]) -> Node
    
    public init(_ token: String, _ nArgs: Int, _ build: @escaping ([Node]) -> Node) {
        self.token = token
        self.nArgs = nArgs
        self.build = build
    }
}

public struct PrefixDefinition: TokenDefinition, Buildable {
    public var token: String
    public var build: ([Node]) -> Node
    
    public init(_ token: String, _ build: @escaping ([Node]) -> Node) {
        self.token = token
        self.build = build
    }
}

public struct PostfixDefinition: TokenDefinition, Buildable {
    public var token: String
    public var build: ([Node]) -> Node
    
    public init(_ token: String, _ build: @escaping ([Node]) -> Node) {
        self.token = token
        self.build = build
    }
}

public struct NumberDefinition: TokenDefinition, BuildableFromString {
    public var token: String
    public var build: ([String]) -> Node
    
    public init(_ token: String, _ build: @escaping ([String]) -> Node) {
        self.token = token
        self.build = build
    }
}

public struct SeparatorDefinition: TokenDefinition {
    public var token: String
    
    public init(_ token: String) {
        self.token = token
    }
}

public struct ConstantDefinition: TokenDefinition, BuildableFromString {
    public var token: String
    public var build: ([String]) -> Node
    
    public init(_ token: String) {
        self.token = token
        self.build = { args in Constant(token) }
    }
}

public struct InfinityDefinition: TokenDefinition, BuildableFromString {
    public var token: String
    public var build: ([String]) -> Node
    
    public init(_ token: String) {
        self.token = token
        self.build = { args in Infinity() }
    }
}

public struct UnknownDefinition: TokenDefinition, BuildableFromString {
    public var token: String
    public var build: ([String]) -> Node
    
    public init(_ token: String) {
        self.token = token
        self.build = { args in Unknown(args[0]) }
    }
}
