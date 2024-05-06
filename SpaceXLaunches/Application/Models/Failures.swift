//
//  Failures.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

struct Failures : Codable {
	let time : Int?
	let altitude : Int?
	let reason : String?

	enum CodingKeys: String, CodingKey {

		case time
		case altitude
		case reason
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		time = try values.decodeIfPresent(Int.self, forKey: .time)
		altitude = try values.decodeIfPresent(Int.self, forKey: .altitude)
		reason = try values.decodeIfPresent(String.self, forKey: .reason)
	}

}
