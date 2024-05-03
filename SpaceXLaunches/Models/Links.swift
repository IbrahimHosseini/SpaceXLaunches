//
//  Links.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation
struct Links : Codable {
	let patch : Patch?
	let reddit : Reddit?
	let flickr : Flickr?
	let presskit : String?
	let webcast : String?
	let youtubeId : String?
	let article : String?
	let wikipedia : String?

	enum CodingKeys: String, CodingKey {

		case patch
		case reddit
		case flickr
		case presskit
		case webcast
		case youtubeId = "youtube_id"
		case article
		case wikipedia
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		patch = try values.decodeIfPresent(Patch.self, forKey: .patch)
		reddit = try values.decodeIfPresent(Reddit.self, forKey: .reddit)
		flickr = try values.decodeIfPresent(Flickr.self, forKey: .flickr)
		presskit = try values.decodeIfPresent(String.self, forKey: .presskit)
		webcast = try values.decodeIfPresent(String.self, forKey: .webcast)
		youtubeId = try values.decodeIfPresent(String.self, forKey: .youtubeId)
		article = try values.decodeIfPresent(String.self, forKey: .article)
		wikipedia = try values.decodeIfPresent(String.self, forKey: .wikipedia)
	}

}
