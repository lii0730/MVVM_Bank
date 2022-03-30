//
//  Account.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import Foundation

enum AccountType: String, Codable, CaseIterable {
    case checking
    case saving
}

extension AccountType {
    var title: String {
        switch self {
        case .checking:
            return "Checking"
        case .saving:
            return "Saving"
        }
    }
}

//MARK: 서버로부터 데이터를 받아오는 모델
struct Account: Codable {
    var id: UUID
    var name: String
    var accountType: AccountType
    var balance: Double
}
