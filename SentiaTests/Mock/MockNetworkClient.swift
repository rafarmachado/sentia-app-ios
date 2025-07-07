//
//  MockNetworkClient.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 07/07/25.
//
import XCTest
@testable import Sentia

final class MockNetworkClient: NetworkClientProtocol {
    enum MockResult {
        case success(Data)
        case failure(Error)
    }

    var result: MockResult?

    func post(url: URL, headers: [String: String], body: [String: Any]) async throws -> Data {
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        case .none:
            fatalError("Mock result was not set")
        }
    }
}
