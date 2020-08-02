//
//  DisplayManager.swift
//  
//
//  Created by Quentin Guidée on 02/08/2020.
//

public protocol DisplayManager {
    func generateDisplayModule(of data: DisplayModuleData) -> DisplayModule
}
