//
//  DisplayModule.swift
//  
//
//  Created by Quentin Guidée on 02/08/2020.
//

public protocol DisplayModule {
    func getDisplay<DisplayType>() -> DisplayType
}

public protocol PercentageDisplayModule: DisplayModule { init(data: PercentageDisplayModuleData) }
public protocol DivisionDisplayModule: DisplayModule { init(data: DivisionDisplayModuleData) }
