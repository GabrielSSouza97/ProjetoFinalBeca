//
//  FormatarNumero.swift
//  CommonsService
//
//  Created by Leticia Sousa Siqueira on 27/01/21.
//

import Foundation

public class FormataNumero {
        
        public init() {
            
        }
        
        public func formatarCotacao(cotacao: Double) -> String {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
            formatter.decimalSeparator = ","
            formatter.groupingSeparator = "."
            let number = NSNumber(value: cotacao)
            let formattedValue = formatter.string(from: number)!
        
            return "$\(formattedValue)"
        }
    
}

