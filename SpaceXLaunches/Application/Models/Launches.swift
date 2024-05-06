//
//  Launches.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation
struct Launches : Codable {
	let docs : [Docs]?
	let totalDocs : Int?
	let limit : Int?
	let totalPages : Int?
	let page : Int?
	let pagingCounter : Int?
	let hasPrevPage : Bool?
	let hasNextPage : Bool?
	let prevPage : Int?
	let nextPage : Int?

	enum CodingKeys: String, CodingKey {

		case docs
		case totalDocs
		case limit
		case totalPages
		case page
		case pagingCounter
		case hasPrevPage
		case hasNextPage
		case prevPage
		case nextPage
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		docs = try values.decodeIfPresent([Docs].self, forKey: .docs)
		totalDocs = try values.decodeIfPresent(Int.self, forKey: .totalDocs)
		limit = try values.decodeIfPresent(Int.self, forKey: .limit)
		totalPages = try values.decodeIfPresent(Int.self, forKey: .totalPages)
		page = try values.decodeIfPresent(Int.self, forKey: .page)
		pagingCounter = try values.decodeIfPresent(Int.self, forKey: .pagingCounter)
		hasPrevPage = try values.decodeIfPresent(Bool.self, forKey: .hasPrevPage)
		hasNextPage = try values.decodeIfPresent(Bool.self, forKey: .hasNextPage)
		prevPage = try values.decodeIfPresent(Int.self, forKey: .prevPage)
		nextPage = try values.decodeIfPresent(Int.self, forKey: .nextPage)
	}

}
