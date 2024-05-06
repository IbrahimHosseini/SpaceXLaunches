//
//  Crew.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

struct Crew : Codable {
	let crew : String?
	let role : String?

	enum CodingKeys: String, CodingKey {

		case crew
		case role
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		crew = try values.decodeIfPresent(String.self, forKey: .crew)
		role = try values.decodeIfPresent(String.self, forKey: .role)
	}

}
