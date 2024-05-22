//
//  Storage.swift
//  SpaceXLaunches
//
//  Created by Ibrahim Hosseini on 5/3/24.
//

import Foundation

/// This Swift protocol named `Storage` defines a set of methods that need to be implemented by any type
/// that conforms to this protocol.
protocol Storage {

    /// The `func save(with id: String)` method defined in the `Storage` protocol is responsible for
    /// saving data associated with a specific identifier. When this method is implemented by a type
    /// conforming to the `Storage` protocol, it should handle the logic of saving data using the
    /// provided identifier. The exact implementation of how the data is saved will depend on the
    /// specific type that conforms to the `Storage` protocol.
    func save(with id: String)

    /// The `func remove(with id: String)` method defined in the `Storage` protocol is responsible for
    /// removing data associated with a specific identifier. When this method is implemented by a type
    /// conforming to the `Storage` protocol, it should handle the logic of removing data using the
    /// provided identifier. The exact implementation of how the data is removed will depend on the
    /// specific type that conforms to the `Storage` protocol.
    func remove(with id: String)

    /// The `func fetchAll() -> [String]` method defined in the `Storage` protocol is responsible for
    /// retrieving all stored data and returning it as an array of strings. When this method is
    /// implemented by a type conforming to the `Storage` protocol, it should handle the logic of
    /// fetching all stored data and returning it in the form of an array of strings. The exact
    /// implementation of how the data is fetched will depend on the specific type that conforms to the
    /// `Storage` protocol.
    func fetchAll() -> [String]

    /// The `func isExist(by id: String) -> Bool` method defined in the `Storage` protocol is
    /// responsible for checking whether data associated with a specific identifier exists in the
    /// storage. When this method is implemented by a type conforming to the `Storage` protocol, it
    /// should handle the logic of determining if data with the provided identifier exists in the
    /// storage. The method returns a boolean value (`true` if the data exists, `false` if it does not)
    /// based on whether the data with the specified identifier is found in the storage.
    func isExist(by id: String) -> Bool

    /// The `func removeAll()` method defined in the `Storage` protocol is responsible for removing all
    /// data stored in the storage. When this method is implemented by a type conforming to the
    /// `Storage` protocol, it should handle the logic of clearing out all stored data, essentially
    /// resetting the storage to an empty state. The exact implementation of how the data is removed
    /// will depend on the specific type that conforms to the `Storage` protocol.
    func removeAll()
}
