//
//  Pow.swift
//  
//
//  Created by Quentin Guidée on 28/06/2020.
//

class Pow: Operator {
    var children: [Node] = []
    var minNumberOfChildren: Int = 2
    var maxNumberOfChildren: Int = 2
    var base: Node { return children[0] }
    var power: Node { return children[1] }
    
    required init() {}
    
    func toString() -> String {
        return base.toString() + "^" + power.toString()
    }
    
    func toLaTeX() -> String {
        return "{" + base.toLaTeX() + "}^{" + power.toLaTeX() + "}"
    }
    
    /*
     Rules:
     
     (x^y)^z    -> x^(y*z)
     (x*y)^z    -> x^z * y^z
     */
}
