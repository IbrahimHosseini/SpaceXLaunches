//
//  APIClient.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

protocol APIClient {
    associatedtype EndpointType: APIEndpoint

    func request<T: Decodable>(_ endpoint: EndpointType) async -> (Result<T, NetworkError>)
}
