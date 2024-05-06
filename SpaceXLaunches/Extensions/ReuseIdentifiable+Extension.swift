//
//  ReuseIdentifiable+Extension.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/6/24.
//

import UIKit

extension ReuseIdentifiable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReuseIdentifiable {}
