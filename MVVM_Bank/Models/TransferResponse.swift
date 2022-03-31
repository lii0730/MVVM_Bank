//
//  TransferResponse.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/31.
//

import Foundation

struct TransferResponse: Decodable {
    let success: Bool
    let error: String?
}
