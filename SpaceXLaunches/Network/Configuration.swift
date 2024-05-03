//
//  Configuration.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 4/30/24.
//

import Foundation

class Configuration {
    static let shared = Configuration()

    var baseURL: String = ""

    private init() {
        if let dictionary = Bundle.main.infoDictionary,
           let configuration = dictionary["Configuration"] as? String {
            let path = Bundle.main.path(forResource: "Configuration", ofType: "plist")
            let config = NSDictionary(contentsOfFile: path!)

            for (key, value) in config! {
                if let key = key as? String,
                   let value = value as? [String: Any] {
                    if key == configuration {
                        baseURL  = value["baseURL"] as? String ?? ""
                        return
                    }
                }
            }
        }
        fatalError("Error: Configuration file doesn't exist in project directory, please include it to be able to use this class")
    }
}
