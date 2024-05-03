//
//  APIEndpoint.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

protocol APIEndpoint {

    /// base of API url
    var baseURL: URL { get }

    /// path of the endpoint API
    var path: String { get }

    /// set the HTTP method of API
    var method: HTTPMethod { get }

    /// set the headers for API
    var headers: [String: String]? { get }

    /// set the API parameters
    var httpBody: [String: Any]? { get }

}

extension APIEndpoint {

    /// set the base url from environment
    var baseURL: URL { URL(string: Constants.baseURL)! }

    var method: HTTPMethod { .get }

    var headers: [String: String]? {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }

    var httpBody: [String: Any]? { [:] }

    public func asURLRequest() throws -> URLRequest {
        
        /// set the path and create the complete url
        let url = baseURL.appendingPathComponent(path)

        var request = URLRequest(url: url)

        request.httpMethod = method.rawValue

        // set the header to request
        request.allHTTPHeaderFields = headers

        request.httpBody = httpBody?.jsonData

        return request
    }
}
