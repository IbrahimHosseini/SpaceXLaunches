//
//  Network.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

class Network<EndpointType: APIEndpoint>: APIClient {

    private let apiHandler: APIHandler
    private let responseHandler: ResponseHandler

    init(
        apiHandler: APIHandler = APIHandlerImp(),
        responseHandler: ResponseHandler = ResponseHandlerImp()
    ) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }

    func request<T: Decodable>(_ endpoint: EndpointType) async -> Result<T, NetworkError> {

        guard let request = try? endpoint.asURLRequest()
        else { return .failure(.badRequest) }

        do {
            let data = try await apiHandler.getData(with: request)
            let response = await responseHandler.getResponse(type: T.self, data: data)

            switch response {
            case .success(let model):
                return .success(model)
            case .failure(let error):
                return .failure(error)
            }

        } catch {
            return .failure(.noData)
        }
    }
}

