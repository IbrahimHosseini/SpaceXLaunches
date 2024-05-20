//
//  APIHandler.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

protocol APIHandler {
    func getData(with request: URLRequest) async throws -> Data
}

class APIHandlerImp: APIHandler {
    func getData(with request: URLRequest) async throws -> Data {
        let (data, _ ) = try await URLSession.shared.data(for: request)
        return data
    }
}


