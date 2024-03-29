//
//  TokensLibrary.swift
//  
//
//  Created by Quentin Guidée on 28/07/2020.
//

public class TokensLibrary {
    public static let integer = NumberDefinition("ℤ", { args in Int(args[0])! })
    public static let real = NumberDefinition("ℝ", { args in Double(args[0])! })
    public static let unknown = UnknownDefinition("�")
    
    public static let allDefinitions: [[TokenDefinition]] = [
        infinities,
        openingBrackets,
        closingBrackets,
        operators,
        constants,
        commands,
        prefixes,
        postfixes,
        separators,
        assignations,
    ]
    
    public static let infinities = [
        InfinityDefinition("∞"),
        InfinityDefinition("inf"),
        InfinityDefinition("infty"),
        InfinityDefinition("infinity"),
    ]
    
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
        OperatorDefinition("^", { args in Pow(args[0], args[1]) }),
        OperatorDefinition("**", { args in Pow(args[0], args[1]) }),
        OperatorDefinition("*", { args in Multiplication(args[0], args[1]) }),
        OperatorDefinition("/", { args in Division(args[0], args[1]) }),
        OperatorDefinition("+", { args in Addition(args[0], args[1]) }),
        OperatorDefinition("-", { args in Addition(args[0], Opposite(args[1])) }),
    ]
    
    public static let constants = Constant.constants.map({ (key, value) in
        ConstantDefinition(key)
    })
    
    public static let commands = [
        CommandDefinition("sin", 1, { args in Sin(args[0]) }),
        CommandDefinition("cos", 1, { args in Cos(args[0]) }),
        CommandDefinition("tan", 1, { args in Tan(args[0]) }),
        CommandDefinition("abs", 1, { args in AbsoluteValue(args[0]) }),
        CommandDefinition("sqrt", 1, { args in Root(args[0], 2) }),
        CommandDefinition("root", 1, { args in Root(args[0], 2) }),
        CommandDefinition("cbrt", 1, { args in Root(args[0], 3) }),
        CommandDefinition("root", 2, { args in Root(args[0], args[1]) }),
        CommandDefinition("fact", 1, { args in Factorial(args[0]) }),
        CommandDefinition("factorial", 1, { args in Factorial(args[0]) }),
        CommandDefinition("int", 1, { args in Integral(args[0]) }),
        CommandDefinition("diff", 1, { args in Differential(args[0]) }),
        CommandDefinition("gcd", 2, { args in Gcd(args[0], args[1]) }),
    ]
    
    public static let prefixes = [
        PrefixDefinition("√", { args in Root(args[0], 2) }),
    ]
    
    public static let postfixes = [
        PostfixDefinition("!", { args in Factorial(args[0]) }),
        PostfixDefinition("𝔦", { args in Complex(0, args[0]) }),
        PostfixDefinition("%", { args in Percent(args[0]) }),
    ]
    
    public static let separators = [
        SeparatorDefinition(","),
    ]
    
    public static let assignations = [
        AssignationDefinition("="),
    ]
}
