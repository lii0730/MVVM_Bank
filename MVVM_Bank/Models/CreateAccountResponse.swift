//
//  CreateAccountResponse.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import Foundation


struct CreateAccountResponse: Decodable {
    let success: Bool
    let error: String?
}
