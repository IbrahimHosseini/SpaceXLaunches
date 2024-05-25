//
//  String+Extension.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import Foundation

extension String {
    var toStringDate: String {
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [
            .withInternetDateTime,
            .withFractionalSeconds
        ]

        guard let date = dateFormatter.date(from: self)
        else { return "date format is not iso8601" }

        // change to a readable time format and change to local time zone
        return date.formatted(date: .long, time: .omitted)
    }
}
