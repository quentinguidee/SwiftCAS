//
//  Pow.swift
//  
//
//  Created by Quentin Guidée on 28/06/2020.
//

class Pow: Operator {
    var base: Node
    var power: Node
    
    init(_ base: Node, _ power: Node) {
        self.base = base
        self.power = power
    }
    
    func toString() -> String {
        return base.toString() + "^" + power.toString()
    }
    
    func toLaTeX() -> String {
        return "{" + base.toLaTeX() + "}^{" + power.toLaTeX() + "}"
    }
    
    func simplify() -> Node {
        simplify(node: &base)
        simplify(node: &power)
        
        if let base = base as? NumericalValue, base.toDouble() == 1 {
            return 1
        } else if let power = power as? NumericalValue, power.toDouble() == 1 {
            return base
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
