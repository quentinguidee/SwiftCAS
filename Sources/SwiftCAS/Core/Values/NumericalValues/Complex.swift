//
//  Complex.swift
//  
//
//  Created by Quentin Guidée on 28/07/2020.
//

public struct Complex: NumericalValue {
    public private(set) var real, imaginary: Node
    public var re: Node { return real }
    public var im: Node { return imaginary }
    
    public var sign: Sign { return .Unknown }
    
    public init(_ real: Node, _ imaginary: Node) {
        self.real = real
        self.imaginary = imaginary
    }
    
    public func shallowCopy() -> Self {
        return Self(real, imaginary)
    }
    
    public func simplified() -> Node {
        switch (real.sign, imaginary.sign) {
            case let (x, y) where x == .Signless && y == .Signless:
                return 0
            case let (_, y) where y == .Signless:
                return real
            default:
                return shallowCopy()
        }
    }
    
    public func toString() -> String {
        switch imaginary.sign {
            case .Positive, .Signless, .Unknown:
                return "\(real.toString())+\(imaginary.toString())𝔦"
            case .Negative:
                return "\(real.toString())\(imaginary.toString())𝔦"
        }
    }
    
    public func toLaTeX() -> String {
        switch imaginary.sign {
            case .Positive, .Signless, .Unknown:
                return "\(real.toLaTeX())+\(imaginary.toLaTeX())i"
            case .Negative:
                return "\(real.toLaTeX())\(imaginary.toLaTeX())i"
        }
    }
    
    public func conjuguate() -> Self {
        return Complex(real, imaginary.opposite())
    }
    
    public func toDouble() -> Double {
        if let real = real as? NumericalValue, real.sign == .Signless {
            return real.toDouble()
        } else {
            return Double.nan
        }
    }
}

extension Complex: Equatable {
    public static func == (lhs: Complex, rhs: Complex) -> Bool {
        return lhs.real.isEqualTo(rhs.real) && lhs.imaginary.isEqualTo(rhs.imaginary)
    }
}
