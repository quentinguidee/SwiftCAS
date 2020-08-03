//
//  Expression.swift
//  
//
//  Created by Quentin Guidée on 02/08/2020.
//

public struct Expression {
    public var input: String
    public var node: Node { return Parser.parse(self.input) }
    public var displayModuleData: DisplayModuleData? {
        if let node = node as? DisplayModuleSupport {
            return node.generateDisplayModuleData()
        }
        return nil
    }
    
    public init(input: String) {
        self.input = input
    }
    
    public func simplified() -> Node {
        return node.simplified()
    }
    
    public func display(with displayManager: DisplayManager) {
        if displayModuleData == nil { return }
        displayManager.generateDisplayModule(of: displayModuleData!).display()
    }
}
