//
//  Options.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

struct Options: Codable {
	var limit: Int = 50
	let page: Int
    let sort: Sort?
}
