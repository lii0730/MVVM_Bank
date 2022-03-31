//
//  AddAccountScreen.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import SwiftUI

struct AddAccountScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject private var addAccountVM = AddAccountViewModel()
    
    
    var body: some View {
        Form {
            TextField("Name", text: self.$addAccountVM.name)
            Picker(selection: self.$addAccountVM.accountType, label: EmptyView()) {
                ForEach(AccountType.allCases, id: \.self) { accountType in
                    Text(accountType.title).tag(accountType)
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            TextField("Balance", text: self.$addAccountVM.balance)
            
            HStack {
                Spacer()
                Button("Submit") {
                    self.addAccountVM.createAccount { success in
                        if success {
                            // 계좌 개설 성공
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                Spacer()
            }
            
            Text(self.addAccountVM.errorMessage)
        }
        .navigationTitle("Add Account")
        .embedInNavigationView()
    }
}

struct AddAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddAccountScreen()
    }
}
