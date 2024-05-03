//
//  Encodable+Extension.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

extension Encodable {
    var toDict: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }

        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        else { return nil }

        return json
    }
}
