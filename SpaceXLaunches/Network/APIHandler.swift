//
//  APIHandler.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

/// The `protocol APIHandler` defines a protocol that requires conforming types to implement a
/// method called `getData(with request: URLRequest)`. This method is marked as `async` which means it
/// can be called asynchronously. It also specifies that the method can throw an error (`throws`) and
/// returns a `Data` object.
protocol APIHandler {
    func getData(with request: URLRequest) async throws -> Data
}

/// The `class APIHandlerImp` is implementing the `APIHandler` protocol. It provides the
/// implementation for the required method `getData(with request: URLRequest) async throws -> Data`.
class APIHandlerImp: APIHandler {
    func getData(with request: URLRequest) async throws -> Data {

        let (data, httpRequest) = try await URLSession.shared.data(for: request)

        guard let statusCode = (httpRequest as? HTTPURLResponse)?.statusCode
        else { throw NetworkError.badRequest }

        if 200..<300 ~=  statusCode {
            return data
        } else if statusCode == 401 {
            throw NetworkError.notFound
        } else {
            throw NetworkError.badRequest
        }
    }
}


