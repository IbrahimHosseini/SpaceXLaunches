//
//  APIClient.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

/// This Swift protocol `APIClient` defines a blueprint for an API client.
protocol APIClient {
    /// The `associatedtype EndpointType: APIEndpoint` in the `APIClient` protocol is defining an
    /// associated type requirement. This means that any type conforming to the `APIClient` protocol
    /// must provide a concrete type for the associated type `EndpointType`, and that type must also
    /// conform to the `APIEndpoint` protocol.
    associatedtype EndpointType: APIEndpoint

    /// This `func request<T: Decodable>(_ endpoint: EndpointType) async -> (Result<T, NetworkError>)`
    /// function in the `APIClient` protocol is a method signature that defines a function for making
    /// asynchronous network requests.
    func request<T: Decodable>(_ endpoint: EndpointType) async -> (Result<T, NetworkError>)
}
