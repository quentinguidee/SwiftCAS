//
//  Node.swift
//  
//
//  Created by Quentin Guidée on 27/06/2020.
//

protocol Node {
    var sign: Sign { get }
    func toString() -> String
    func toLaTeX() -> String
    func absoluteValue() -> Self
}
