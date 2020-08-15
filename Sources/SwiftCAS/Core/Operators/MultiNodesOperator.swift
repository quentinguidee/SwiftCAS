//
//  MultiNodesOperator.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

public protocol MultiNodesOperator: AnyObject, Node {
    var symbol: String { get }
    var children: [Node] { get set }
    var neutral: Int { get }
    init()
}

extension MultiNodesOperator {
    public init(_ children: [Node]) {
        self.init()
        self.children = children
    }
    
    public init(_ children: Node...) {
        self.init(children)
    }
    
    public func toString() -> String {
        return children.map({ $0.toString() }).joined(separator: symbol)
    }
    
    public func toLaTeX() -> String {
        return children.map({ $0.toLaTeX() }).joined(separator: symbol)
    }
    
    public func mergeAllChildren() {
        for child in children {
            if let child = child as? Self {
                child.mergeAllChildren()
                self.append(children: child.children)
            }
        }
        
        self.removeAllChildren(where: { type(of: $0) == Self.self })
    }
    
    public func append(children: Node...) {
        append(children: children)
    }
    
    public func append(children: [Node]) {
        children.forEach { self.append(child: $0) }
    }
    
    public func append(child: Node) {
        children.append(child)
    }
    
    public func removeAllChildren(where: (Node) -> Bool) {
        children.removeAll(where: `where`)
    }
    
    public func removeAllNeutrals() {
        children.removeAll(where: { ($0 as? NumericalValue)?.toDouble() == self.neutral.toDouble() })
    }
    
    public func simplify(children: inout [Node]) {
        for i in 0..<children.count {
            children[i] = children[i].simplified()
        }
    }
}
