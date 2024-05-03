//
//  NetworkError.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case noData
    case decodingFailed
    case badRequest

    var errorDescription: String? {
        switch self {
        case .invalidURL: "Invalid Url"
        case .noData: "No Data"
        case .decodingFailed: "Decoding Failed"
        case .badRequest: "Bad Request"
        }
    }
}
