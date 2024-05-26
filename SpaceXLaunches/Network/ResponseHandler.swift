//
//  ResponseHandler.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

protocol ResponseHandler {
    func getResponse<T: Decodable>(type: T.Type, data: Data) async -> Result<T, NetworkError>
}

class ResponseHandlerImp: ResponseHandler {
    func getResponse<T: Decodable>(type: T.Type, data: Data) async -> Result<T, NetworkError> {

        do {
            let response = try JSONDecoder().decode(type.self, from: data)
            return .success(response)
        } catch {
            return .failure(.decodingFailed)
        }
    }
}
