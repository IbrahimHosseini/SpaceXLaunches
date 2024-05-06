//
//  Flickr.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

struct Flickr : Codable {
	let small : [String]?
	let original : [String]?

	enum CodingKeys: String, CodingKey {

		case small
		case original
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		small = try values.decodeIfPresent([String].self, forKey: .small)
		original = try values.decodeIfPresent([String].self, forKey: .original)
	}

}
