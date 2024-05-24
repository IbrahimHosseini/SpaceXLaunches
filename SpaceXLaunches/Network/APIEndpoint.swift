//
//  APIEndpoint.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

protocol APIEndpoint {
    
    /// The `var baseURL: URL { get }` in the `APIEndpoint` protocol is declaring a read-only computed
    /// property named `baseURL` of type `URL`. This property is part of the protocol requirements,
    /// meaning any type that conforms to the `APIEndpoint` protocol must provide an implementation for
    /// this property.
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

    /// The line `var method: HTTPMethod { .get }` in the `APIEndpoint` protocol extension is providing
    /// a default implementation for the `method` property. It is setting the default HTTP method for
    /// the API endpoint to be `.get`, which is typically used for retrieving data from the server.
    var method: HTTPMethod { .get }

    /// The `var headers: [String: String]?` property in the `APIEndpoint` protocol extension is
    /// providing a default implementation for the `headers` property. It is setting default headers for
    /// the API request. In this case, it is setting the `Accept` and `Content-Type` headers to indicate
    /// that the API endpoint expects and sends data in JSON format.
    var headers: [String: String]? {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }

    /// The `var httpBody: [String: Any]? { [:] }` line in the `APIEndpoint` protocol extension is
    /// providing a default implementation for the `httpBody` property. It is setting the default value
    /// of `httpBody` to an empty dictionary `[:]`. This means that if a specific API endpoint
    /// conforming to the `APIEndpoint` protocol does not provide a custom implementation for the
    /// `httpBody` property, it will default to an empty dictionary when creating the API request.
    var httpBody: [String: Any]? { [:] }

    // This `asURLRequest()` function is part of the `APIEndpoint` protocol extension in Swift. It is a
    // method that converts the endpoint information into a `URLRequest` object that can be used to
    // make network requests.
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
