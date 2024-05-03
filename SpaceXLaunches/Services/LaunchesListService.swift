//
//  LaunchesList.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

protocol LaunchesListService {
    func fetch(with query: QueryDTO) async -> Result<Launches, NetworkError>
}

class LaunchesListServiceImp: LaunchesListService {

    private let network: Network<LaunchesAPI>

    init(network: Network<LaunchesAPI>) {
        self.network = network
    }

    func fetch(with query: QueryDTO) async -> Result<Launches, NetworkError> {
        await network.request(LaunchesAPI.launches(query: query))
    }

}
