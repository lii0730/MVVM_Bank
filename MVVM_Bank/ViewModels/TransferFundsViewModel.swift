//
//  TransferFundsViewModel.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/31.
//

import Foundation


class TransferFundsViewModel: ObservableObject {
    var fromAccount: AccountViewModel?
    var toAccount: AccountViewModel?
    
    @Published var message: String?
    
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    var amount: String = ""
    
    var isAmountValid: Bool {
        guard let userAmount = Double(amount) else {
            return false
        }
        
        return userAmount <= 0 ? false : true
    }
    
    var filteredAccounts: [AccountViewModel] {
        
        if self.fromAccount == nil {
            return accounts
        } else {
            return accounts.filter {
                
                guard let fromAccount = self.fromAccount else { return false }
                
                return $0.accountId != fromAccount.accountId
            }
        }
        
    }
    
    var fromAccountType: String {
        fromAccount != nil ? fromAccount!.accountType : ""
    }
    
    var toAccountType: String {
        toAccount != nil ? toAccount!.accountType : ""
    }
    
    private func isValid() -> Bool {
        return isAmountValid
    }
    
    func submitTransfer(completion: @escaping () -> Void) {
        
        if !isValid() {
            return
        }
        
        guard let fromAccount = fromAccount,
              let toAccount = toAccount,
              let amount = Double(self.amount)
        else {
            return
        }
        
        let transferRequest = TransferRequest(
            accountFromId: fromAccount.accountId.lowercased(),
            accountToId: toAccount.accountId.lowercased(),
            amount: amount
        )
        
        AccountService.shared.transferFunds(transferRequest: transferRequest) { result in
            switch result {
            case .success(let response):
                if response.success {
                    completion()
                } else {
                    DispatchQueue.main.async {
                        self.message = response.error
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.message = error.localizedDescription
                }
            }
        }

        
    }
    
    
    func populateAccounts() {
        AccountService.shared.getAllAccounts { result in
            switch result {
            case .success(let accounts):
                if let accounts = accounts {
                    DispatchQueue.main.async {
                        self.accounts = accounts.map(AccountViewModel.init)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
