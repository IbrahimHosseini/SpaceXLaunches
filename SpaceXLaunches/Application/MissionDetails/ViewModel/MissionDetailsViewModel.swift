//
//  MissionDetailsViewModel.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import Combine

class MissionDetailsViewModel: ObservableObject {
    @Published var imageUrl: String = ""
    @Published var missionName: String = ""
    @Published var missionDetails: String = ""
    @Published var missionDate: String = ""
    @Published var wikiLink: String = ""
    @Published var isMarked: Bool = false

    private var service: MissionDetailsService?
    
    init(service: MissionDetailsService) {

        self.service = service

        // get launch details and update UI
        updateUI()

        // check the item that is was bookmarked or not
        let status = getIsMarkedStatus()

        // update isMarked value
        changeIsMarkedStatus(status)

    }

    // MARK: - functions
    
    func removeBookmark() {
        guard let service else { return }
        service.removeFromFavorite()
    }
    
    func addBookmark() {
        guard let service else { return }
        service.addToFavorite()
    }

    public func bookmarkChanges(_ isMarked: Bool) {
        guard let service else { return }

        if isMarked {
            addBookmark()
        } else {
            removeBookmark()
        }

        changeIsMarkedStatus(isMarked)
    }

    private func changeIsMarkedStatus(_ status: Bool) {
        self.isMarked = status
    }

    private func getIsMarkedStatus() -> Bool {
        guard let service else { return false }

        return service.isMarked()
    }

    private func getLaunchDetails() -> Docs? {
        guard let service else { return nil }

        return service.getDetails()
    }
    
    // MARK: - helper
    // updateUI refactor
    func updateUI() {
        guard let docs = getLaunchDetails() else { return }
        updateUI(docs)
    }

    private func updateUI(_ docs: Docs) {
        imageUrl = docs.links?.patch?.small ?? ""
        missionName = docs.name ?? ""
        missionDate = docs.staticFireDateUTC?.toStringDate ?? ""
        missionDetails = docs.details ?? ""
        wikiLink = docs.links?.wikipedia ?? ""
    }
}

