//
//  Double+Extensions.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import Foundation


extension Double {
    
    func formatAsCurrency() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency // 통화 변경
        let formattedCurrency = formatter.string(from: self as NSNumber)
        return formattedCurrency ?? ""
        
    }
    
}
