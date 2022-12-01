//
//  APIManager.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 11/30/22.
//

import Foundation

protocol APIManagerProtocol {
    func getTodos() async throws -> [Todo]
}

struct APIManager: APIManagerProtocol {
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }
    
    func getTodos() async throws -> [Todo] {
        do {
            return try await apiService.fetch(dataType: [Todo].self)
        } catch {
            throw APIError.failedToGetTodo
        }
    }
    
}
