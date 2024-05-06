//
//  MissionDetailsService.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import Foundation

protocol MissionDetailsService {
    func getDetails() -> Docs?
    func addToFavorite()
    func removeFromFavorite()
    func fetchBookmarks() -> [String]
    func isMarked() -> Bool
}

class MissionDetailsServiceImp: MissionDetailsService {

    private let docs: Docs
    private let storageService: Storage
    private let id: String

    init(
        docs: Docs,
        storageService: Storage,
        id: String
    ) {
        self.docs = docs
        self.storageService = storageService
        self.id = id
    }

    func getDetails() -> Docs? { docs }

    func addToFavorite() {
        storageService.save(with: id)
    }

    func removeFromFavorite() {
        storageService.remove(with: id)
    }

    func fetchBookmarks() -> [String] {
        storageService.fetchAll()
    }

    func isMarked() -> Bool {
        storageService.isExist(by: id)
    }

}
