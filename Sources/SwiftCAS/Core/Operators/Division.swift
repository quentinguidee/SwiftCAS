//
//  Division.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

class Division: Operator {
    var children: [Node] = []
    var minNumberOfChildren: Int = 2
    var maxNumberOfChildren: Int = 2
    
    required init() {}
    
    func toString() -> String {
        return children[0].toString() + "/" + children[1].toString()
    }
    
    func toLaTeX() -> String {
        return "\\frac{" + children[0].toLaTeX() + "}{" + children[1].toLaTeX() + "}"
    }
}
