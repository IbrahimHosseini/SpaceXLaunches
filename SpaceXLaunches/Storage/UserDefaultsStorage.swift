//
//  UserDefaultsStorage.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import Foundation

class UserDefaultStorage: Storage {

    private var keys: [String]

    private let key: String

    private let userDefaults = UserDefaults.standard

    init(key: String) {
        self.key = key
        keys = userDefaults.stringArray(forKey: key) ?? []
    }

    func save(with id: String) {
        keys.append(id)
        userDefaults.setValue(keys, forKey: key)
    }

    func remove(with id: String) {
        keys = keys.filter { $0 != id }
        userDefaults.setValue(keys, forKey: key)
    }

    func fetchAll() -> [String] {
        keys
    }

    func isExist(by id: String) -> Bool {
        keys.contains(id)
    }

    func removeAll() {
        userDefaults.removeObject(forKey: key)
    }
}
