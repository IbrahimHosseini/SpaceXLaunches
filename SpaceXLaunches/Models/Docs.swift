//
//  Docs.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

struct Docs : Codable {
	let fairings : Fairings?
	let links : Links?
	let staticFireDateUTC : String?
	let staticFireDateUnix : Int?
	let net : Bool?
	let window : Int?
	let rocket : String?
	let success : Bool?
	let failures : [Failures]?
	let details : String?
	let crew : [Crew]?
	let ships : [String]?
	let capsules : [String]?
	let payloads : [String]?
	let launchpad : String?
	let flightNumber : Int?
	let name : String?
	let dateUTC : String?
	let dateUnix : Int?
	let dateLocal : String?
	let datePrecision : String?
	let upcoming : Bool?
	let cores : [Cores]?
	let autoUpdate : Bool?
	let tbd : Bool?
	let launchLibraryId : String?
	let id : String?

	enum CodingKeys: String, CodingKey {

		case fairings
		case links
		case staticFireDateUTC = "static_fire_date_utc"
		case staticFireDateUnix = "static_fire_date_unix"
		case net
		case window
		case rocket
		case success
		case failures
		case details
		case crew
		case ships
		case capsules
		case payloads
		case launchpad
		case flightNumber = "flight_number"
		case name
		case dateUTC = "date_utc"
		case dateUnix = "date_unix"
		case dateLocal = "date_local"
		case datePrecision = "date_precision"
		case upcoming
		case cores
		case autoUpdate = "auto_update"
		case tbd
		case launchLibraryId = "launch_library_id"
		case id
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		fairings = try values.decodeIfPresent(Fairings.self, forKey: .fairings)
		links = try values.decodeIfPresent(Links.self, forKey: .links)
		staticFireDateUTC = try values.decodeIfPresent(String.self, forKey: .staticFireDateUTC)
		staticFireDateUnix = try values.decodeIfPresent(Int.self, forKey: .staticFireDateUnix)
		net = try values.decodeIfPresent(Bool.self, forKey: .net)
		window = try values.decodeIfPresent(Int.self, forKey: .window)
		rocket = try values.decodeIfPresent(String.self, forKey: .rocket)
		success = try values.decodeIfPresent(Bool.self, forKey: .success)
		failures = try values.decodeIfPresent([Failures].self, forKey: .failures)
		details = try values.decodeIfPresent(String.self, forKey: .details)
		crew = try values.decodeIfPresent([Crew].self, forKey: .crew)
		ships = try values.decodeIfPresent([String].self, forKey: .ships)
		capsules = try values.decodeIfPresent([String].self, forKey: .capsules)
		payloads = try values.decodeIfPresent([String].self, forKey: .payloads)
		launchpad = try values.decodeIfPresent(String.self, forKey: .launchpad)
		flightNumber = try values.decodeIfPresent(Int.self, forKey: .flightNumber)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		dateUTC = try values.decodeIfPresent(String.self, forKey: .dateUTC)
		dateUnix = try values.decodeIfPresent(Int.self, forKey: .dateUnix)
		dateLocal = try values.decodeIfPresent(String.self, forKey: .dateLocal)
		datePrecision = try values.decodeIfPresent(String.self, forKey: .datePrecision)
		upcoming = try values.decodeIfPresent(Bool.self, forKey: .upcoming)
		cores = try values.decodeIfPresent([Cores].self, forKey: .cores)
		autoUpdate = try values.decodeIfPresent(Bool.self, forKey: .autoUpdate)
		tbd = try values.decodeIfPresent(Bool.self, forKey: .tbd)
		launchLibraryId = try values.decodeIfPresent(String.self, forKey: .launchLibraryId)
		id = try values.decodeIfPresent(String.self, forKey: .id)
	}

}
