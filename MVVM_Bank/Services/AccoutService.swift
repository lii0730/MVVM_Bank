//
//  AccoutService.swift
//  MVVM_Bank
//
//  Created by LeeHsss on 2022/03/30.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case decodingError
    case noData
}

class AccountService {
    
    private init() { }
    static let shared = AccountService()
    
    func createAccount(createAccountRequest: CreateAccountRequest, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) {
        
        guard let url = URL.urlForCreateAccounts() else { return completion(.failure(.badUrl)) }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        //Body에 Data를 담아서 서버로 전송!
        request.httpBody = try? JSONEncoder().encode(createAccountRequest) // POST할 때는 Encoding!
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let createAccountResponse = try? JSONDecoder().decode(CreateAccountResponse.self, from: data)
            
            if let createAccountResponse = createAccountResponse {
                completion(.success(createAccountResponse))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getAllAccounts(completion: @escaping (Result<[Account]?, NetworkError>) -> Void) {
        guard let url = URL.urlForAccounts() else {
            return completion(.failure(.badUrl))
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let accounts = try? JSONDecoder().decode([Account].self, from: data)
            
            if accounts == nil {
                completion(.failure(.decodingError))
            } else {
                completion(.success(accounts))
            }
            
            
        }.resume()
    }
    
    func transferFunds(transferRequest: TransferRequest, completion: @escaping (Result<TransferResponse, NetworkError>) -> Void) {
        guard let url = URL.urlForTransferAccounts() else {
            return completion(.failure(.badUrl))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(transferRequest)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let transferResponse = try? JSONDecoder().decode(TransferResponse.self, from: data)
            
            if let transferResponse = transferResponse {
                completion(.success(transferResponse))
            } else {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
}
