//
//  Options.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

struct Options: Codable {
	var limit: Int
	let page: Int
    let sort: Sort
}
