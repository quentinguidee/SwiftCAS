//
//  Expression.swift
//  
//
//  Created by Quentin Guidée on 02/08/2020.
//

import Foundation

public struct Expression: Identifiable {
    public var id = UUID()
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
    
    public func getDisplay<DisplayType>(with displayManager: DisplayManager, as: DisplayType.Type) -> DisplayType? {
        if displayModuleData == nil { return nil }
        return displayManager.generateDisplayModule(of: displayModuleData!).getDisplay()
    }
}
