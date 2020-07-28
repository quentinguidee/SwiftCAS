//
//  String.swift
//  
//
//  Created by Quentin Guidée on 28/07/2020.
//

extension String {
    public var isNumeric: Bool {
        return Double(self) != nil
    }
    
    public var isOpeningBrackets: Bool {
        return TokensLibrary.openingBrackets.contains(where: { $0.token == self })
    }
    
    public var isClosingBrackets: Bool {
        return TokensLibrary.closingBrackets.contains(where: { $0.token == self })
    }
}
