//
//  Parser.swift
//  
//
//  Created by Quentin Guidée on 04/07/2020.
//

public class Parser {
    static let operations = [["^"], ["*", "/"], ["+", "-"]]
    
    static let openingBrackets = ["(", "{", "["]
    
    static let closingBrackets = [")", "}", "]"]
    
    public static func parse(_ expression: String) -> Node {
        // -> x^2.0+x+3
        var array: [Any] = self.array(of: expression)
        // -> ["x", "2", ".", "0", "+", "x", "+", "3"]
        
        return parse(&array)[0] as! Node
    }
    
    public static func parse(_ array: inout [Any]) -> [Any] {
        // Step 1: Match all parentheses and transform them into subarrays
        replaceParenthesesBySubArrays(&array)
        
        // Step 2: Transform all "." as a floating point number, with the two adjacent characters
        replaceDotsByDoubles(&array)
        // -> ["x", 2.0, "+", "x", "+", "3"]
        
        // Step 3: Transform str into Objects
        replaceStringsByNodes(&array)
        // -> [Unknown("x"), 2.0, "+", Unknown("x"), "+", 3]
        
        var i = 0
        while i < array.count {
            if var x = array[i] as? Array<Any> {
                let _ = self.parse(&x)
                if x.count == 1 {
                    array[i] = x[0]
                } else {
                    array[i] = x
                }
            }
            
            i += 1
        }
        
        // Step 4: Replace operations with objects
        replaceOperatorsByNodes(&array)
        // -> [Addition((Addition(Unknown("x"), 2.0)), 3)]
        
        return array
    }
    
    public static func array(of expression: String) -> [Any] {
        var array: [Any] = []
        var latestChar = ""
        
        for char in expression {
            if latestChar == "" {
                latestChar = String(char)
            } else if Parser.type(of: latestChar) != CharacterType.Parenthese && Parser.type(of: latestChar) == Parser.type(of: String(char)) {
                latestChar.append(char)
            } else {
                array.append(latestChar)
                latestChar = String(char)
            }
        }
        
        array.append(latestChar)
        
        return array
    }
    
    static func replaceParenthesesBySubArrays(_ array: inout [Any]) {
        var i = 0
        var matchingParentheseCount = 0
        
        while i < array.count {
            if self.openingBrackets.contains(String(describing: array[i])) {
                matchingParentheseCount = 1
                
                // Search the closing index
                var j = i + 1
                while j < array.count {
                    if self.openingBrackets.contains(String(describing: array[j])) {
                        matchingParentheseCount += 1
                    } else if self.closingBrackets.contains(String(describing: array[j])) {
                        matchingParentheseCount -= 1
                    }
                    
                    if matchingParentheseCount == 0 {
                        break
                    }
                    
                    j += 1
                }
                
                array[i...j] = [Array(array[i+1...j-1])]
            }
            
            i += 1
        }
    }
    
    static func replaceDotsByDoubles(_ array: inout [Any]) {
        var i: Int = 0
        while i < array.count {
            if String(describing: array[i]) == "." {
                if (i+1) < array.count {
                    array[(i-1)...(i+1)] = [Double("\(array[i-1]).\(array[i+1])")!]
                }
            } else {
                i += 1
            }
        }
    }
    
    static func replaceStringsByNodes(_ array: inout [Any]) {
        for i in 0..<array.count {
            if let _ = array[i] as? Array<Any> {
                continue
            } else if !(array[i] is Node) && getOperatorType(of: String(describing: array[i])) == nil {
                let char = String(describing: array[i])
                array[i] = NodeFactory.create(char)
            }
        }
    }
    
    static func replaceOperatorsByNodes(_ array: inout [Any]) {
        var i = 0
        
        for operation in self.operations {
            i = 0
            
            while i < array.count {
                let character = String(describing: array[i])
                
                if operation.contains(character), let operatorType = self.getOperatorType(of: character) {
                    if (i+1) < array.count {
                        array[(i-1)...(i+1)] = [operatorType.create(array[i-1] as! Node, array[i+1] as! Node)]
                    }
                } else {
                    i += 1
                }
            }
        }
    }
    
    static func getOperatorType(of operation: String) -> OperatorType? {
        switch operation {
            case "^": return .PowOperator
            case "*": return .MultiplicationOperator
            case "/": return .DivisionOperator
            case "+": return .AdditionOperator
            default:  return nil
        }
    }
    
    enum OperatorType {
        case PowOperator
        case MultiplicationOperator
        case DivisionOperator
        case AdditionOperator
        
        func create(_ nodeA: Node, _ nodeB: Node) -> Node {
            switch self {
                case .PowOperator:
                    return Pow(nodeA, nodeB)
                case .MultiplicationOperator:
                    return Multiplication(nodeA, nodeB)
                case .DivisionOperator:
                    return Division(nodeA, nodeB)
                case .AdditionOperator:
                    return Addition(nodeA, nodeB)
            }
        }
    }
    
    enum CharacterType {
        case Int, Double, Operator, Constant, Infinity, Comma, Unknown, Parenthese
    }
    
    static func type(of char: String) -> CharacterType {
        if let _ = Int(char) {
            return .Int
        } else if let _ = Double(char) {
            return .Double
        } else if let _ = getOperatorType(of: char) {
            return .Operator
        } else if let _ = Constant.constants[char] {
            return .Constant
        } else if char == Infinity.symbol {
            return .Infinity
        } else if self.openingBrackets.contains(char) || self.closingBrackets.contains(char) {
            return .Parenthese
        } else if char == "," {
            return .Comma
        } else {
            return .Unknown
        }
    }
}
