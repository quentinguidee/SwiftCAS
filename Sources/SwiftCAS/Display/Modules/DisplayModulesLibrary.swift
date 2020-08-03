//
//  DisplayModulesLibrary.swift
//  
//
//  Created by Quentin Guidée on 03/08/2020.
//

public struct DisplayModulesLibrary {
    public let percentage: PercentageDisplayModule.Type
    public let division: DivisionDisplayModule.Type
    
    public init(
        percentage: PercentageDisplayModule.Type,
        division: DivisionDisplayModule.Type) {
        
        self.percentage = percentage
        self.division = division
    }
}
