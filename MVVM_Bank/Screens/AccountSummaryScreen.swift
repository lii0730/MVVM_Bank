//
//  AccountSummaryScreen.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import SwiftUI

struct AccountSummaryScreen: View {
    
    @ObservedObject private var accountSummaryVM = AccountSummaryViewModel()
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            GeometryReader { g in
                VStack {
                    AccountListView(accounts: self.accountSummaryVM.accounts)
                        .frame(height: g.size.height / 2)
                    Text("\(self.accountSummaryVM.total.formatAsCurrency())")
                        
                    Spacer()
                }
            }
        }
        .onAppear {
            self.accountSummaryVM.getAllAccounts()
        }
        .sheet(isPresented: $isPresented, onDismiss: {
            // sheet 닫히고 나면 다시 한번 불러옴
            self.accountSummaryVM.getAllAccounts()
        }, content: {
            AddAccountScreen()
        })
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Add Account") {
                    self.isPresented = true
                }
            }
        })
        .navigationTitle("Account Summary")
        .embedInNavigationView()
    }
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}