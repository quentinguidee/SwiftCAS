//
//  NodeFactory.swift
//  
//
//  Created by Quentin Guidée on 04/07/2020.
//

class NodeFactory {
    static func create(_ expression: Any) -> Node {
        switch expression {
            case is Node:
                return expression as! Node
            case is String:
                if let i = Int(expression as! String) {
                    return i
                } else if let d = Double(expression as! String) {
                    return d
                } else if let _ = Constant.constants[expression as! String] {
                    return Constant(expression as! String)
                } else if expression as! String == Infinity.symbol {
                    return Infinity()
                } else {
                    return Unknown(expression as! String)
                }
            default:
                break
        }
        print("Fatal error will occur: \(expression)")
        fatalError("The Node class cannot handle nodes of these type")
    }
}
