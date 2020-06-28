//
//  Rule.swift
//  
//
//  Created by Quentin Guidée on 28/06/2020.
//

struct Rule {
    var expression: Node
    var replacement: Node
}

extension String: Node {
    func toString() -> String {
        return self
    }
    
    func toLaTeX() -> String {
        return self
    }
}

// Example :
// var rules: [Rule] = [
//     Rule(expression: Addition(0, "$0"), replacement: "$0"),
//     Rule(expression: Addition("$0", 0), replacement: "$0")
// ]
