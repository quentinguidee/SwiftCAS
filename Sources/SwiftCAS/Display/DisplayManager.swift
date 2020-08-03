//
//  DisplayManager.swift
//  
//
//  Created by Quentin Guidée on 02/08/2020.
//

public class DisplayManager {
    let displayModulesLibrary: DisplayModulesLibrary
    
    public init(_ displayModulesLibrary: DisplayModulesLibrary) {
        self.displayModulesLibrary = displayModulesLibrary
    }
    
    public func generateDisplayModule(of data: DisplayModuleData) -> DisplayModule {
        switch data {
            case let data as PercentageDisplayModuleData:
                return displayModulesLibrary.percentage.init(data: data)
            case let data as DivisionDisplayModuleData:
                return displayModulesLibrary.division.init(data: data)
            default:
                fatalError()
        }
    }
}
