//
//  Set.swift
//  
//
//  Created by Quentin Guidée on 19/08/2020.
//

protocol Set {
    static var symbol: String { get }
    
    static func contains(_ node: Node) -> Bool
}
