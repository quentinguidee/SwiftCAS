//
//  Root.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

prefix operator √
public prefix func √(lhs: Node) -> Node { return Root(lhs) }

public class Root: Operator {
    public var sign: Sign { return .Positive }
    var radicand: Node
    var index: Node
    
    public required init(_ radicand: Node, _ index: Node) {
        self.radicand = radicand
        self.index = index
    }
    
    public convenience init(_ radicand: Node) {
        self.init(radicand, 2)
    }
    
    public func simplify() -> Node {
        return Pow(radicand, Division(1, index)).simplify()
    }
    
    public func toString() -> String {
        switch self {
            case let x where x.isSquareRoot():
                return "sqrt(" + radicand.toString() + ")"
            case let x where x.isCubeRoot():
                return "cbrt(" + radicand.toString() + ")"
            default:
                return "root(" + radicand.toString() + ", " + index.toString() + ")"
        }
    }
    
    public func toLaTeX() -> String {
        switch self {
            case let x where x.isSquareRoot():
                return "\\sqrt{" + radicand.toLaTeX() + "}"
            default:
                return "\\sqrt[" + index.toLaTeX() + "]{" + radicand.toLaTeX() + "}"
        }
    }
    
    public func isSquareRoot() -> Bool {
        let i = index as? NumericalValue
        return i?.toDouble() == 2 ? true : false
    }
    
    public func isCubeRoot() -> Bool {
        let i = index as? NumericalValue
        return i?.toDouble() == 3 ? true : false
    }
}
