//
//  Sort.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

struct Sort: Codable {
    var flightNumber: Order = .desc

	enum CodingKeys: String, CodingKey {

		case flightNumber = "flight_number"
	}

}

enum Order: String, Codable {
    case desc, asc
}
