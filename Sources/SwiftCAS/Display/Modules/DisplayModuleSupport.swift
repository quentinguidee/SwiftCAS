//
//  DisplayModuleDataSupport.swift
//  
//
//  Created by Quentin Guidée on 03/08/2020.
//

protocol DisplayModuleSupport {
    func generateDisplayModuleData() -> DisplayModuleData?
}

extension Percent: DisplayModuleSupport {
    func generateDisplayModuleData() -> DisplayModuleData? {
        if let percentage = simplified() as? Double, percentage >= 0, percentage <= 1 {
            return PercentageDisplayModuleData(percentage: percentage)
        } else {
            return nil
        }
    }
}

extension Division: DisplayModuleSupport {
    func generateDisplayModuleData() -> DisplayModuleData? {
        if let denominator = denominator as? Int, let numerator = numerator as? NumericalValue {
            return DivisionDisplayModuleData(
                cellValue: numerator.toDouble()/denominator.toDouble(),
                numberOfCells: denominator
            )
        } else {
            return nil
        }
    }
}
