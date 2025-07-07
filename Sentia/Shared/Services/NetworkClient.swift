//
//  NetworkClient.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 06/07/25.
//
import Foundation

// MARK: - NetworkClientProtocol

/// A protocol to abstract away network calls for testability and flexibility.
protocol NetworkClientProtocol {
    func post(url: URL, headers: [String: String], body: [String: Any]) async throws -> Data
}

// MARK: - NetworkClient

/// Default implementation of NetworkClientProtocol using URLSession.
final class NetworkClient: NetworkClientProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func post(url: URL, headers: [String: String], body: [String: Any]) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }

        guard JSONSerialization.isValidJSONObject(body) else {
            throw EncodingError.invalidValue(body, .init(codingPath: [], debugDescription: "Body is not a valid JSON object"))
        }

        request.httpBody = try JSONSerialization.data(withJSONObject: body)

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return data
    }
}
