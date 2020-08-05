//
//  Storage.swift
//  
//
//  Created by Quentin Guidée on 05/08/2020.
//

public class Storage {
    public static var variables: [Variable] = []
    
    static func save(_ symbol: String, _ value: Node) {
        variables.append(Variable(symbol: symbol, value: value))
    }
    
    static func getVariable(_ symbol: String) -> Node? {
        for variable in variables {
            if variable.symbol == symbol { return variable.value }
        }
        return nil
    }
}
