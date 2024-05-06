//
//  Cores.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

struct Cores : Codable {
	let core : String?
	let flight : Int?
	let gridfins : Bool?
	let legs : Bool?
	let reused : Bool?
	let landingAttempt : Bool?
	let landingSuccess : Bool?
	let landingType : String?
	let landpad : String?

	enum CodingKeys: String, CodingKey {

		case core
		case flight
		case gridfins
		case legs
		case reused
		case landingAttempt = "landing_attempt"
		case landingSuccess = "landing_success"
		case landingType = "landing_type"
		case landpad
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		core = try values.decodeIfPresent(String.self, forKey: .core)
		flight = try values.decodeIfPresent(Int.self, forKey: .flight)
		gridfins = try values.decodeIfPresent(Bool.self, forKey: .gridfins)
		legs = try values.decodeIfPresent(Bool.self, forKey: .legs)
		reused = try values.decodeIfPresent(Bool.self, forKey: .reused)
        landingAttempt = try values.decodeIfPresent(Bool.self, forKey: .landingAttempt)
		landingSuccess = try values.decodeIfPresent(Bool.self, forKey: .landingSuccess)
		landingType = try values.decodeIfPresent(String.self, forKey: .landingType)
		landpad = try values.decodeIfPresent(String.self, forKey: .landpad)
	}

}
