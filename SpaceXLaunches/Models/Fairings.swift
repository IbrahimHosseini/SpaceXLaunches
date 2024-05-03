//
//  Fairings.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

struct Fairings: Codable {
	let reused: Bool?
	let recoveryAttempt: Bool?
	let recovered: Bool?
	let ships: [String]?

	enum CodingKeys: String, CodingKey {

		case reused
		case recoveryAttempt = "recovery_attempt"
		case recovered
		case ships
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		reused = try values.decodeIfPresent(Bool.self, forKey: .reused)
        recoveryAttempt = try values.decodeIfPresent(Bool.self, forKey: .recoveryAttempt)
		recovered = try values.decodeIfPresent(Bool.self, forKey: .recovered)
		ships = try values.decodeIfPresent([String].self, forKey: .ships)
	}

}
