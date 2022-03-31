//
//  TransferFundsScreen.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/31.
//

import SwiftUI

struct TransferFundsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var transferFundsVM = TransferFundsViewModel()
    @State private var showSheet: Bool = false
    @State private var isFromAcount: Bool = false
    
    var actionSheetButtons: [Alert.Button] {
        var actionButtons = self.transferFundsVM.filteredAccounts.map { account in
            Alert.Button.default(Text("\(account.name) (\(account.accountType))")) {
                if self.isFromAcount {
                    self.transferFundsVM.fromAccount = account
                } else {
                    self.transferFundsVM.toAccount = account
                }
            }
        }
        
        actionButtons.append(.cancel())
        
        return actionButtons
    }
    
    var body: some View {
        ScrollView {
            VStack {
                AccountListView(accounts: self.transferFundsVM.accounts)
                    .frame(height: 300)
                
                TransferFundsAccountSelectionView(transferFundsVM: self.transferFundsVM, showSheet: $showSheet, isFromAccount: $isFromAcount)
                
                Spacer()
                    .onAppear {
                        self.transferFundsVM.populateAccounts()
                    }
                
                Text(self.transferFundsVM.message ?? "")
                
                Button("Submit Transfer") {
                    self.transferFundsVM.submitTransfer {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                .padding()
                .actionSheet(isPresented: $showSheet) {
                    ActionSheet(title: Text("Transfer Funds"), message: Text("Choose an account"), buttons: self.actionSheetButtons)
                }
            }
        }
        .navigationTitle("Transfer Funds")
        .embedInNavigationView()
        
    }
}

struct TransferFundsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransferFundsScreen()
    }
}

struct TransferFundsAccountSelectionView: View {
    
    @ObservedObject var transferFundsVM: TransferFundsViewModel
    @Binding var showSheet: Bool
    @Binding var isFromAccount: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            Button("From \(self.transferFundsVM.fromAccountType)") {
                self.isFromAccount = true
                self.showSheet = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.green)
            .foregroundColor(.white)
            
            Button("To \(self.transferFundsVM.toAccountType)") {
                self.isFromAccount = false
                self.showSheet = true
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.green)
            .foregroundColor(.white)
            .opacity(self.transferFundsVM.fromAccount != nil ? 1.0 : 0.5)
            .disabled(self.transferFundsVM.fromAccount == nil)
            
            TextField("Amount", text: self.$transferFundsVM.amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
        }
    }
}
