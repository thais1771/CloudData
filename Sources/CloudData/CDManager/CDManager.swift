//
//  CDManager.swift
//
//  Created by Thais Rodríguez on 9/6/24.
//

import CloudKit

/// A class that manages CloudKit operations such as fetching records from different databases.
/// `CDManager` conforms to `ObservableObject` to allow SwiftUI views to react to changes in the object.
public class CDManager: ObservableObject {
    // MARK: - Properties
    /// The configuration settings for the CDManager.
    let configuration: CDManagerConfig

    // MARK: CloudKit Properties
    /// The CloudKit container initialized with the provided container identifier.
    lazy var container = CKContainer(identifier: configuration.containerIdentifier)
    /// The CloudKit database determined by the configuration.
    lazy var database = getDatabase()

    // MARK: - Initializers
    /// Initializes a new instance of CDManager with the provided configuration.
    ///
    /// - Parameter config: The configuration object containing settings for the CDManager.
    public init(withConfiguration config: CDManagerConfig) {
        self.configuration = config
    }

    // MARK: - Actions
    /// Fetches records of a specified type from a specified zone in the CloudKit database.
    ///
    /// - Parameters:
    ///   - recordType: The type of records to fetch.
    ///   - zoneName: The name of the zone to fetch records from. Defaults to `nil`.
    /// - Returns: An array of dictionaries representing the fetched records.
    /// - Throws: An error if the fetch operation fails.
    public func fetch(recordType type: String,
                      fromZoneName zoneName: String? = nil) async throws -> [[String: Any]]
    {
        try await fetchRecords(recordType: type,
                               fromZoneName: zoneName).toDictionary()
    }

    /// Fetches CloudKit records of a specified type from a specified zone.
    ///
    /// - Parameters:
    ///   - recordType: The type of records to fetch.
    ///   - zoneName: The name of the zone to fetch records from. Defaults to `nil`.
    /// - Returns: An array of `CKRecord` objects representing the fetched records.
    /// - Throws: An error if the fetch operation fails when accessing the database.
    public func fetchRecords(recordType type: String,
                             fromZoneName zoneName: String? = nil) async throws -> [CKRecord]
    {
        switch configuration.cloudType {
        case .private:
            return try await getPrivateRecords(recordType: type, fromZoneName: zoneName)
        case .public:
            throw CDManagerFetchError.unableToFetchPublicDatabase
        case .shared:
            throw CDManagerFetchError.unableToFetchSharedDatabase
        }
    }
}
