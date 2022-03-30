//
//  AccountViewModel.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import Foundation

class AccountViewModel: ObservableObject {
    var account: Account
    
    init(account: Account) {
        self.account = account
    }
    
    var name: String {
        account.name
    }
    
    var accountId: String {
        account.id.uuidString
    }
    
    var accountType: String {
        account.accountType.title
    }
    
    var balance: Double {
        account.balance
    }
}
