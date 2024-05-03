//
//  LaunchesAPI.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

enum LaunchesAPI: APIEndpoint {
    case launches(query: QueryDTO)

    var path: String { Paths.launches }

    var httpBody: [String : Any]? {
        switch self {
        case .launches(let query):
            return query.toDict
        }
    }

    var method: HTTPMethod { .post }
}
