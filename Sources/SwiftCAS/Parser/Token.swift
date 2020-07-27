//
//  Token.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

public struct Token: CustomStringConvertible {
    public static let integer = NumberDefinition("ℤ", { args in Int(args[0] as! String)! })
    public static let real = NumberDefinition("ℝ", { args in Double(args[0] as! String)! })
    public static let unknown = UnknownDefinition("�", { args in Unknown(args[0] as! String) })
    
    public static let tokenDefinitions: [[TokenDefinition]] = [
        openingBrackets,
        closingBrackets,
        operators,
        commands,
        surrounds,
        prefixes,
        postfixes
    ]
    
    public static let openingBrackets = [
        OpeningBracketDefinition("(", { args in [args] }),
        OpeningBracketDefinition("{", { args in [args] }),
        OpeningBracketDefinition("[", { args in [args] }),
    ]
    
    public static let closingBrackets = [
        ClosingBracketDefinition(")", { args in [args] }),
        ClosingBracketDefinition("}", { args in [args] }),
        ClosingBracketDefinition("]", { args in [args] }),
    ]
    
    public static let operators = [
        OperatorDefinition("^", { args in Pow(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("**", { args in Pow(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("*", { args in Multiplication(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("/", { args in Division(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("+", { args in Addition(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("-", { args in Addition(args[0] as! Node, Opposite(args[1] as! Node)) }),
    ]
    
    public static let commands = [
        CommandDefinition("sin", 1, { args in Sin(args[0] as! Node) }),
        CommandDefinition("cos", 1, { args in Cos(args[0] as! Node) }),
        CommandDefinition("tan", 1, { args in Tan(args[0] as! Node) }),
        CommandDefinition("sqrt", 1, { args in Root(args[0] as! Node, 2) }),
        CommandDefinition("root", 1, { args in Root(args[0] as! Node, 2) }),
        CommandDefinition("cbrt", 1, { args in Root(args[0] as! Node, 3) }),
        CommandDefinition("root", 2, { args in Root(args[0] as! Node, args[1] as! Node) }),
    ]
    
    public static let surrounds = [
        SurroundDefinition("|", { args in AbsoluteValue(args[0] as! Node) }),
    ]
    
    public static let prefixes = [
        PrefixDefinition("√", { args in Root(args[0] as! Node, 2) }),
    ]
    
    public static let postfixes = [
        PostfixDefinition("!", { args in Factorial(args[0] as! Node) }),
    ]
    
    // ---------------------------
    
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
        if element.isNumeric {
            return integer
        } else if element == "." {
            return real
        }
        
        for subTokenDefinitions in tokenDefinitions {
            for tokenDefinition in subTokenDefinitions {
                if tokenDefinition.token == element { return tokenDefinition }
            }
        }
        
        return unknown
    }
}
