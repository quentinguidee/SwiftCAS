//
//  Operator.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol Operator: Node {
    var nodes: [Node] { get set }
    var minOfNodes: Int { get set }
    var maxOfNodes: Int { get set }
    init()
}

extension Operator {
    init(_ nodes: [Node]) {
        self.init()
        assert(nodes.count >= minOfNodes && nodes.count <= maxOfNodes, "Wrong number of nodes")
        self.nodes = nodes
    }
    
    init(_ nodes: Node...) {
        self.init(nodes)
    }
}
