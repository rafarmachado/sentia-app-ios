//
//  NetworkClientTests.swift
//  Sentia
//
//  Created by Rafael Rezende Machado on 03/07/25.
//


import XCTest
@testable import Sentia

final class NetworkClientTests: XCTestCase {
    var sut: NetworkClient!
    var session: URLSession!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        session = URLSession(configuration: config)
        sut = NetworkClient(session: session)
    }

    override func tearDown() {
        sut = nil
        session = nil
        MockURLProtocol.requestHandler = nil
        super.tearDown()
    }

    func test_post_successfulResponse_returnsData() async throws {
        // Given
        let expectedData = """
        { "message": "success" }
        """.data(using: .utf8)!

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, expectedData)
        }

        // When
        let result = try await sut.post(url: URL(string: "https://example.com")!,
                                        headers: [:],
                                        body: ["key": "value"])

        // Then
        XCTAssertEqual(result, expectedData)
    }

    func test_post_unsuccessfulResponse_throwsURLError() async throws {
        // Given
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!,
                                           statusCode: 500,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (response, Data())
        }

        // When
        do {
            _ = try await sut.post(
                url: URL(string: "https://example.com")!,
                headers: [:],
                body: ["key": "value"]
            )
            XCTFail("Expected to throw, but did not")
        } catch {
            // Then
            XCTAssertTrue(error is URLError)
        }
    }

    func test_post_encodingError_throwsError() async throws {
        // Given
        let invalidBody: [String: Any] = ["invalid": Date()]

        // When
        do {
            _ = try await sut.post(
                url: URL(string: "https://example.com")!,
                headers: [:],
                body: invalidBody
            )
            XCTFail("Expected to throw encoding error, but did not")
        } catch {
            // Then
            XCTAssertTrue(error is EncodingError || error is NSError)
        }
    }
}
