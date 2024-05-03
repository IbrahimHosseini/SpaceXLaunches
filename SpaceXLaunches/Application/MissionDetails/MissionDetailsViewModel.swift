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

    init() {

    }
}
