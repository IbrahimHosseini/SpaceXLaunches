//
//  Patch.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation
struct Patch : Codable {
	let small : String?
	let large : String?

	enum CodingKeys: String, CodingKey {

		case small
		case large
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		small = try values.decodeIfPresent(String.self, forKey: .small)
		large = try values.decodeIfPresent(String.self, forKey: .large)
	}

}
