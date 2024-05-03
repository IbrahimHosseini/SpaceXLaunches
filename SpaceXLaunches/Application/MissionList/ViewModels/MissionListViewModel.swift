//
//  MissionListViewModel.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Combine

class MissionListViewModel: ObservableObject {

    @Published var launchesList: Launches? = nil
    @Published var error: String?

    private var service: LaunchesListService

    init(service: LaunchesListService) {
        self.service = service
    }

    @MainActor
    func fetch() async {

        let query = Query(upcoming: false)
        let sort = Sort(flightNumber: .desc)
        let options = Options(page: 1, sort: sort)


        let queryDTO = QueryDTO(
            query: query,
            options: options
        )

        let result = await service.fetch(with: queryDTO)

        switch result {
        case .success(let list):
            self.launchesList = list
        case .failure(let failure):
            self.error = failure.errorDescription ?? "try again later"
        }
    }
}
