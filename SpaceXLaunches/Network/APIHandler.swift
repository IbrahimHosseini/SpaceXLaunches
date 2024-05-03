//
//  APIHandler.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

protocol APIHandler {
    func getData<T: Decodable> (type: T.Type, url: URLRequest) async throws -> Data
}

class APIHandlerImp: APIHandler {
    func getData<T>(type: T.Type, url: URLRequest) async throws -> Data where T : Decodable {
        let (data, _ ) = try await URLSession.shared.data(for: url)
        return data
    }
}
