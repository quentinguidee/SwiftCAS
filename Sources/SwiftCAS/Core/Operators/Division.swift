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
    var numerator: Node { return children[0] }
    var deniminator: Node { return children[1] }
    var dividend: Node { return numerator }
    var divisor: Node { return deniminator }
    
    required init() {}
    
    func toString() -> String {
        return numerator.toString() + "/" + deniminator.toString()
    }
    
    func toLaTeX() -> String {
        return "\\frac{" + numerator.toLaTeX() + "}{" + deniminator.toLaTeX() + "}"
    }
    
    /*
     Rules:
     
     x/1        -> x
     x/0        -> ERR
     cst/cst    -> 1
     */
    func simplify() -> Node {
        if let d = deniminator as? Int, d == 1 {
            return numerator
        } else if let d = deniminator as? Double, d == 1 {
            return numerator
        }
        return self
    }
}
