//
//  TransferRequest.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/31.
//

import Foundation

struct TransferRequest: Codable {
    let accountFromId: String
    let accountToId: String
    let amount: Double
}
