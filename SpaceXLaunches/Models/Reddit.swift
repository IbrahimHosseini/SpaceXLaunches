//
//  Reddit.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation
struct Reddit : Codable {
	let campaign : String?
	let launch : String?
	let media : String?
	let recovery : String?

	enum CodingKeys: String, CodingKey {
		case campaign
		case launch
		case media
		case recovery
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		campaign = try values.decodeIfPresent(String.self, forKey: .campaign)
		launch = try values.decodeIfPresent(String.self, forKey: .launch)
		media = try values.decodeIfPresent(String.self, forKey: .media)
		recovery = try values.decodeIfPresent(String.self, forKey: .recovery)
	}

}
