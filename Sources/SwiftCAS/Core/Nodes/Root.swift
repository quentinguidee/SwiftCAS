//
//  Root.swift
//  
//
//  Created by Quentin Guidée on 26/07/2020.
//

prefix operator √
public prefix func √(lhs: Node) -> Node { return Root(lhs) }

public class Root: Node {
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
    
    public func shallowCopy() -> Self {
        return Self(radicand, index)
    }
    
    public func simplified() -> Node {
        return Pow(radicand, Division(1, index)).simplified()
    }
    
    public func prettified() -> Node {
        return Root(radicand.prettified(), index.prettified())
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

extension Root: Equatable {
    public static func == (lhs: Root, rhs: Root) -> Bool {
        return lhs.radicand.isEqualTo(rhs.radicand) && lhs.index.isEqualTo(rhs.index)
    }
}
