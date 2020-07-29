//
//  Dimension.swift
//  
//
//  Created by Quentin Guidée on 29/07/2020.
//

public typealias Order = Dimension

public struct Dimension {
    var n: Int
    var m: Int
    
    init(_ n: Int, _ m: Int) {
        self.n = n
        self.m = m
    }
}
