//
//  AccountSummaryViewModel.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import Foundation

class AccountSummaryViewModel: ObservableObject {
    
    private var _accountModels = [Account]()
    
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()
    
    var total: Double {
        _accountModels.map { $0.balance }.reduce(0, +) // 총합
    }
    
    //MARK: 모든 계좌 정보를 서버에서 긁어오는 함수
    func getAllAccounts() {
        
        AccountService.shared.getAllAccounts { result in
            switch result {
            case .success(let accounts):
                if let accounts = accounts {
                    self._accountModels = accounts
                    DispatchQueue.main.async {
                        self.accounts = self._accountModels.map { AccountViewModel(account: $0) }
                    }
                }
            case .failure(let error):
                print("Failure \(error.localizedDescription)")
            }
        }
        
    }
    
}
