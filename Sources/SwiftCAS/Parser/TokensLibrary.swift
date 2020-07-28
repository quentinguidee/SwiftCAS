//
//  TokensLibrary.swift
//  
//
//  Created by Quentin Guidée on 28/07/2020.
//

public class TokensLibrary {
    public static let integer = NumberDefinition("ℤ", { args in Int(args[0] as! String)! })
    public static let real = NumberDefinition("ℝ", { args in Double(args[0] as! String)! })
    public static let unknown = UnknownDefinition("�", { args in Unknown(args[0] as! String) })
    
    public static let openingBrackets = [
        OpeningBracketDefinition("("),
        OpeningBracketDefinition("{"),
        OpeningBracketDefinition("["),
    ]
    
    public static let closingBrackets = [
        ClosingBracketDefinition(")"),
        ClosingBracketDefinition("}"),
        ClosingBracketDefinition("]"),
    ]
    
    public static let operators = [
        OperatorDefinition("^", { args in Pow(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("**", { args in Pow(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("*", { args in Multiplication(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("/", { args in Division(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("+", { args in Addition(args[0] as! Node, args[1] as! Node) }),
        OperatorDefinition("-", { args in Addition(args[0] as! Node, Opposite(args[1] as! Node)) }),
    ]
    
    public static let constants = Constant.constants.map({ (key, value) in
        ConstantDefinition(key)
    })
    
    public static let commands = [
        CommandDefinition("sin", 1, { args in Sin(args[0] as! Node) }),
        CommandDefinition("cos", 1, { args in Cos(args[0] as! Node) }),
        CommandDefinition("tan", 1, { args in Tan(args[0] as! Node) }),
        CommandDefinition("abs", 1, { args in AbsoluteValue(args[0] as! Node) }),
        CommandDefinition("sqrt", 1, { args in Root(args[0] as! Node, 2) }),
        CommandDefinition("root", 1, { args in Root(args[0] as! Node, 2) }),
        CommandDefinition("cbrt", 1, { args in Root(args[0] as! Node, 3) }),
        CommandDefinition("root", 2, { args in Root(args[0] as! Node, args[1] as! Node) }),
        CommandDefinition("fact", 1, { args in Factorial(args[0] as! Node) }),
        CommandDefinition("factorial", 1, { args in Factorial(args[0] as! Node) }),
        CommandDefinition("int", 1, { args in Integral(args[0] as! Node) }),
        CommandDefinition("diff", 1, { args in Differential(args[0] as! Node) }),
    ]
    
    public static let prefixes = [
        PrefixDefinition("√", { args in Root(args[0] as! Node, 2) }),
    ]
    
    public static let postfixes = [
        PostfixDefinition("!", { args in Factorial(args[0] as! Node) }),
    ]
    
    public static let separators = [
        SeparatorDefinition(","),
    ]
    
    public static let infinities = [
        InfinityDefinition("∞"),
        InfinityDefinition("inf"),
        InfinityDefinition("infty"),
        InfinityDefinition("infinity"),
    ]
}
