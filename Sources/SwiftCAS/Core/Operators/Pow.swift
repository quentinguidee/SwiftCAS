//
//  Pow.swift
//  
//
//  Created by Quentin Guidée on 28/06/2020.
//

class Pow: Operator {
    var base: Node
    var power: Node
    
    func toString() -> String {
        return base.toString() + "^" + power.toString()
    }
    
    func toLaTeX() -> String {
        return "{" + base.toLaTeX() + "}^{" + power.toLaTeX() + "}"
    }
    
    init(_ base: Node, _ power: Node) {
        self.base = base
        self.power = power
    }
    
    /*
     Rules:
     
     (x^y)^z    -> x^(y*z)
     (x*y)^z    -> x^z * y^z
     1^x        -> 1
     */
    
    func simplify() -> Node {
        if let base = base as? NumericalValue, base.toDouble() == 1 {
            return 1
        } else if let base = base as? Pow {
            return Pow(base.base, Multiplication(base.power, power))
        } else if let base = base as? Multiplication {
            var n: [Pow] = []
            base.children.forEach { child in n.append(Pow(child, power)) }
            return Multiplication(n)
        }
        return self
    }
}
