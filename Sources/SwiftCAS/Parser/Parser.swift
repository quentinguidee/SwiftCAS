//
//  Parser.swift
//  
//
//  Created by Quentin Guidée on 04/07/2020.
//

public class Parser {
    static let operations = [["^"], ["*", "/"], ["+", "-"]]
    
    public static func parse(_ expression: String) -> Node {
        // -> x^2.0+x+3
        
        // Step 1: Transform the expression into a basic Array
        var array: [Any] = self.array(of: expression)
        // -> ["x", "2", ".", "0", "+", "x", "+", "3"]
        
        // Step 2: Transform all "." as a floating point number, with the two adjacent characters
        replaceDotsByDoubles(&array)
        // -> ["x", 2.0, "+", "x", "+", "3"]
        
        // Step 3: Transform str into Objects
        replaceStringsByNodes(&array)
        // -> [Unknown("x"), 2.0, "+", Unknown("x"), "+", 3]
        
        // Step 4: Replace operations with objects
        replaceOperatorsByNodes(&array)
        // -> [Addition((Addition(Unknown("x"), 2.0)), 3)]
        
        return array[0] as! Node
    }
    
    public static func array(of expression: String) -> [Any] {
        var array: [Any] = []
        
        for char in expression {
            array.append(char)
        }
        
        return array
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
            if !(array[i] is Node) && getOperatorType(of: String(describing: array[i])) == nil {
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
}
