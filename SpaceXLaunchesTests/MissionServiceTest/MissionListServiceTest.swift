//
//  MissionListServiceTest.swift
//  SpaceXLaunchesTests
//
//  Created by Ibrahim Hosseini on 5/6/24.
//

import XCTest

@testable import SpaceXLaunches

final class MissionListServiceTest: XCTestCase {

    var service: MockMissionListService!

    override func setUp() {
        super.setUp()

        service = MockMissionListService()
    }

    override func tearDown() {
        service = nil

        super.tearDown()

    }

    func test_checkLimitCountDocs() async {

        let result = await getData(limit: 10, order: .desc, page: 1)

        switch result {
        case .success(let launches):
            XCTAssertEqual(10, launches.docs?.count)
        case .failure(let error):
            XCTFail("Error: \(error.localizedDescription)")
        }
    }

    func test_checkACSOrder() async {
        let result = await getData(limit: 10, order: .asc, page: 1)

        switch result {
        case .success(let launches):
            XCTAssertEqual(launches.docs![0].flightNumber!, 1)
        case .failure(let error):
            XCTFail("Error: \(error.localizedDescription)")
        }
    }

}

extension MissionListServiceTest {
    fileprivate func getData(limit: Int, order: Order, page: Int) async ->  Result<Launches, NetworkError> {

        let query = QueryDTO(
            query: Query(upcoming: false),
            options: Options(
                limit: limit,
                page: page,
                sort: .init(flightNumber: order)
            )
        )

        let result = await service.fetch(with: query)

        return result
    }
}
