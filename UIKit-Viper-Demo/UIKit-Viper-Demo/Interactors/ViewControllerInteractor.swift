//
//  ViewControllerInteractor.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 12/1/22.
//

import Foundation

protocol ViewControllerInteractorProtocol {
    func getTodos() async throws -> [Todo]
}

class ViewControllerInteractor {
    private let apiManager: APIManagerProtocol
    
    init(apiManager: APIManagerProtocol) {
        self.apiManager = apiManager
    }
}

extension ViewControllerInteractor: ViewControllerInteractorProtocol {
    func getTodos() async throws -> [Todo] {
        do {
            return try await apiManager.getTodos()
        } catch {
            throw APIError.failedToGetTodo
        }
    }
}
