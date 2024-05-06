//
//  MockMissionListService.swift
//  SpaceXLaunchesTests
//
//  Created by Ibrahim Hosseini on 5/6/24.
//

import XCTest

@testable import SpaceXLaunches

class MockMissionListService: LaunchesListService {
    func fetch(with query: QueryDTO) async -> Result<Launches, SpaceXLaunches.NetworkError> {

        let type = type(of: self)
        let bundle = Bundle(for: type.self)

        guard let path = bundle.url(forResource: "mockJSON", withExtension: "json")
        else { return .failure(.invalidURL) }

        guard let data = try? Data(contentsOf: path)
        else { return .failure(.noData) }

        guard let model = try? JSONDecoder().decode(Launches.self, from: data)
        else { return .failure(.decodingFailed) }

        return .success(model)
    }

}


