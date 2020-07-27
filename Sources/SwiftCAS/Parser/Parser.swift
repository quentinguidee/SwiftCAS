//
//  Parser.swift
//  
//
//  Created by Quentin Guidée on 04/07/2020.
//

public class Parser {
    static let operations: [[TokenDefinition]] = [
        [Token.getDefinition(of: "^"), Token.getDefinition(of: "**")],
        [Token.getDefinition(of: "*"), Token.getDefinition(of: "/")],
        [Token.getDefinition(of: "+"), Token.getDefinition(of: "-")]
    ]
    
    public static func parse(_ expression: String) -> Node {
        if expression == "" { return 0 }
        
        var array: [Any] = Lexer.tokenized(expression)
        
        parse(&array)
        
        return array[0] as! Node
    }
    
    public static func parse(_ array: inout [Any]) {
        replaceParenthesesBySubArrays(&array)
        parseRecursively(&array)
        replaceTokensByNodes(&array)
        replaceOperatorsByNodes(&array)
        replaceCommandsByNodes(&array)
        replacePrefixesByNodes(&array)
        replacePostfixesByNodes(&array)
    }
    
    public static func parseRecursively(_ array: inout [Any]) {
        var i = 0
        while i < array.count {
            if var x = array[i] as? Array<Any> {
                let _ = self.parse(&x)
                array[i] = x.count == 1 ? x[0] : x
            }
            i += 1
        }
    }
    
    static func replaceParenthesesBySubArrays(_ array: inout [Any]) {
        var i = 0
        var matchingParentheseCount = 0
        
        while i < array.count {
            if let itemI = array[i] as? Token, itemI.tokenDefinition is OpeningBracketDefinition {
                matchingParentheseCount = 1
                
                // Search the closing index
                var j = i + 1
                while j < array.count {
                    if let itemJ = array[j] as? Token {
                        switch itemJ.tokenDefinition {
                            case is OpeningBracketDefinition: matchingParentheseCount += 1
                            case is ClosingBracketDefinition: matchingParentheseCount -= 1
                            default: break
                        }
                    }
                    
                    if matchingParentheseCount == 0 { break }
                    j += 1
                }
                array[i...j] = [Array(array[i+1...j-1])]
            }
            i += 1
        }
    }
    
    static func replaceTokensByNodes(_ array: inout [Any]) {
        for i in 0..<array.count {
            if let _ = array[i] as? Array<Any> {
                continue
            } else if let item = array[i] as? Token, !(item.tokenDefinition is OperatorDefinition
                                                        || item.tokenDefinition is CommandDefinition
                                                        || item.tokenDefinition is SurroundDefinition
                                                        || item.tokenDefinition is PrefixDefinition
                                                        || item.tokenDefinition is PostfixDefinition) {
                array[i] = item.build(item.value)
            }
        }
    }
    
    static func replaceOperatorsByNodes(_ array: inout [Any]) {
        var i = 0
        
        for operation in self.operations {
            //TODO: Replace by an enum "Direction" RightToLeft and LeftToRight
            if operation.contains(where: { $0.token == "^" || $0.token == "**" }) {
                i = array.count-1
                while i > 0 {
                    if let token = array[i] as? Token, operation.contains(where: { $0.token == token.tokenDefinition.token }) {
                        if (i-1) >= 0 {
                            array[(i-1)...(i+1)] = [token.build(array[i-1] as! Node, array[i+1] as! Node)]
                            i -= 2
                        }
                    } else {
                        i -= 1
                    }
                }
            } else {
                i = 0
                while i < array.count {
                    if let token = array[i] as? Token, operation.contains(where: { $0.token == token.tokenDefinition.token }) {
                        if (i+1) < array.count {
                            array[(i-1)...(i+1)] = [token.build(array[i-1] as! Node, array[i+1] as! Node)]
                        }
                    } else {
                        i += 1
                    }
                }
            }
        }
    }
    
    static func replaceCommandsByNodes(_ array: inout [Any]) {
        var i = 0
        while i < array.count {
            if let token = array[i] as? Token, token.tokenDefinition is CommandDefinition {
                if (i+1) < array.count {
                    array[(i)...(i+1)] = [token.build(array[i+1])]
                }
            } else {
                i += 1
            }
        }
    }
    
    static func replacePrefixesByNodes(_ array: inout [Any]) {
        var i = 0
        while i < array.count {
            if let token = array[i] as? Token, token.tokenDefinition is PrefixDefinition {
                if (i+1) < array.count {
                    array[(i)...(i+1)] = [token.build(array[i+1])]
                }
            } else {
                i += 1
            }
        }
    }
    
    static func replacePostfixesByNodes(_ array: inout [Any]) {
        var i = 0
        while i < array.count {
            if let token = array[i] as? Token, token.tokenDefinition is PostfixDefinition {
                if i < array.count {
                    array[(i-1)...(i)] = [token.build(array[i-1])]
                }
            } else {
                i += 1
            }
        }
    }
}
