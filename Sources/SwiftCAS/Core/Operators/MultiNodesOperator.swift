//
//  MultiNodesOperator.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol MultiNodesOperator: AnyObject, Operator {
    var symbol: String { get set }
    var children: [Node] { get set }
    init()
}

extension MultiNodesOperator {
    init(_ children: [Node]) {
        self.init()
        self.children = children
    }
    
    init(_ children: Node...) {
        self.init(children)
    }
    
    func toString() -> String {
        var s: String = ""
        children.forEach { s += $0.toString() + symbol }
        return String(s.dropLast())
    }
    
    func toLaTeX() -> String {
        var s: String = ""
        children.forEach { s += $0.toLaTeX() + symbol }
        return String(s.dropLast())
    }
    
    func mergeAllChildren() {
        for child in children {
            if let child = child as? Self {
                child.mergeAllChildren()
                self.append(children: child.children)
            }
        }
        
        self.removeAllChildren(where: { type(of: $0) == Self.self })
    }
    
    func append(children: Node...) {
        append(children: children)
    }
    
    func append(children: [Node]) {
        children.forEach({ self.append(child: $0) })
    }
    
    func append(child: Node) {
        children.append(child)
    }
    
    func removeAllChildren(where: (Node) -> Bool) {
        children.removeAll(where: `where`)
    }
    
    func simplify(children: inout [Node]) {
        for i in 0..<children.count {
            children[i] = children[i].simplify()
        }
    }
}
