//
//  AccountListView.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import SwiftUI

struct AccountListView: View {
    
    let accounts: [AccountViewModel]
    
    var body: some View {
        List(accounts, id: \.accountId) { account in
            AccountCell(account: account)
        }.listStyle(.plain)
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        
        let account = Account(id: UUID(), name: "John Doe", accountType: .checking, balance: 200)
        let accountVM = AccountViewModel(account: account)
        
        AccountListView(accounts: [accountVM])
    }
}

struct AccountCell: View {
    
    let account: AccountViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(account.name)
                    .font(.headline)
                Text(account.accountType)
                    .opacity(0.5)
            }
            Spacer()
            Text("\(account.balance.formatAsCurrency())")
                .foregroundColor(.green)
        }
    }
}
