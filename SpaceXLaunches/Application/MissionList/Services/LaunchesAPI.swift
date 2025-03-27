//
//  LaunchesAPI.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

// Define a specific query DTO for launches to avoid ambiguity
struct LaunchQueryDTO {
    let query: [String: Any]
    
    enum CodingKeys: String, CodingKey {
        case query
    }
}

extension LaunchQueryDTO {
    var toDict: [String: Any] {
        return ["query": query]
    }
}

extension LaunchQueryDTO: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Since [String: Any] is not directly Encodable, we need to handle it manually
        // For simplicity, we'll convert it to a JSON string and encode that
        if let jsonData = try? JSONSerialization.data(withJSONObject: query),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            try container.encode(jsonString, forKey: .query)
        } else {
            throw EncodingError.invalidValue(query, EncodingError.Context(
                codingPath: [CodingKeys.query],
                debugDescription: "Could not encode query dictionary"
            ))
        }
    }
}

// We need to implement Decodable separately
extension LaunchQueryDTO: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let jsonString = try container.decode(String.self, forKey: .query)
        
        if let jsonData = jsonString.data(using: .utf8),
           let jsonDict = try? JSONSerialization.jsonObject(with: jsonData) as? [String: Any] {
            self.query = jsonDict
        } else {
            self.query = [:]
            throw DecodingError.dataCorruptedError(
                forKey: .query,
                in: container,
                debugDescription: "Could not decode query string to dictionary"
            )
        }
    }
}

enum LaunchesAPI: APIEndpoint {
    case launches(query: LaunchQueryDTO)

    var path: String { Paths.launches }

    var httpBody: [String : Any]? {
        switch self {
        case .launches(let query):
            return query.toDict
        }
    }

    var method: HTTPMethod { .post }
}

// Add a function to fetch launches data
class LaunchesService {
    private let network = Network<LaunchesAPI>()
    
    /// Fetches launches data from the SpaceX API
    /// - Parameter query: The query parameters to filter launches
    /// - Returns: A Result containing either the decoded response or a NetworkError
    func fetchLaunches<T: Decodable>(query: LaunchQueryDTO) async -> Result<T, NetworkError> {
        return await network.request(.launches(query: query))
    }
}
