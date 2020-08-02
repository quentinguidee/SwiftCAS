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
        if let node = node as? DisplayModuleDataSupport {
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

protocol DisplayModuleDataSupport {
    func generateDisplayModuleData() -> DisplayModuleData?
}

extension Percent: DisplayModuleDataSupport {
    func generateDisplayModuleData() -> DisplayModuleData? {
        if let simplified = simplified() as? Double {
            return PercentageDisplayModuleData(percentage: simplified)
        } else {
            return nil
        }
    }
}
