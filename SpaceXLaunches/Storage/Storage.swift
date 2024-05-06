//
//  Storage.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import Foundation

protocol Storage {
    func save(with id: String)
    func remove(with id: String)
    func fetchAll() -> [String]
    func isExist(by id: String) -> Bool
    func removeAll()
}
