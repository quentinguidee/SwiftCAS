//
//  Operator.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol Operator: Node {
    var children: [Node] { get set }
    var minNumberOfChildren: Int { get set }
    var maxNumberOfChildren: Int { get set }
    init()
}

extension Operator {
    init(_ children: [Node]) {
        self.init()
        assert(children.count >= minNumberOfChildren && children.count <= maxNumberOfChildren, "Wrong number of nodes")
        self.children = children
    }
    
    init(_ children: Node...) {
        self.init(children)
    }
}
