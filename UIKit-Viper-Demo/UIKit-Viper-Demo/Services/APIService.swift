//
//  APIService.swift
//  UIKit-Viper-Demo
//
//  Created by Samreth Kem on 11/30/22.
//

import Foundation

protocol APIServiceProtocol {
    func fetch<T: Decodable>(dataType: T.Type) async throws -> T
}

class APIService: APIServiceProtocol {
    func fetch<T>(dataType: T.Type) async throws -> T where T : Decodable {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://jsonplaceholder.typicode.com/todos")!)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            throw APIError.failedFetching
        }
    }
}
