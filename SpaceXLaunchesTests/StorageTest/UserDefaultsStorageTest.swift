//
//  UserDefaultsStorageTest.swift
//  SpaceXLaunchesTests
//
//  Created by Ibrahim Hosseini on 5/6/24.
//

import XCTest
@testable import SpaceXLaunches

final class UserDefaultsStorageTest: XCTestCase {

    var storage: Storage?

    override func setUp() {
        super.setUp()
        storage = UserDefaultStorage(key: "testKey")
    }

    override func tearDown() {
        super.tearDown()
        removeAll()
        storage = nil
    }

    func test_saveToStorage() {
        storage?.save(with: UUID().uuidString)

        let allData = fetchAll()

        XCTAssertEqual(1, allData.count)
    }

    func test_removeFromStorage() {
        let id = UUID().uuidString

        storage?.save(with: id)

        storage?.remove(with: id)

        let allData = fetchAll()

        XCTAssertEqual(0, allData.count)
    }

    func test_isExistItem() {
        let id = UUID().uuidString

        storage?.save(with: id)

        let isExist = storage!.isExist(by: id)

        XCTAssertTrue(isExist)
    }

    func test_isNotExistItem() {
        let id = UUID().uuidString

        storage?.save(with: id)

        let isExist = storage!.isExist(by: "id")

        XCTAssertFalse(isExist)
    }

}

extension UserDefaultsStorageTest {
    private func fetchAll() -> [String] {
        storage!.fetchAll()
    }

    private func removeAll() {
        storage!.removeAll()
    }
}

