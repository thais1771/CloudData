//
//  CDManager.swift
//
//  Created by Thais Rodríguez on 9/6/24.
//

import CloudKit

/// A class to manage interactions with a CloudKit database.
public class CDManager: ObservableObject {
    // MARK: - Properties
    let configuration: CDManagerConfig

    // MARK: CloudKit Properties
    /// The CloudKit container used to manage CloudKit interactions.
    ///
    /// - Note: Based on the configuration
    lazy var container = CKContainer(identifier: configuration.containerIdentifier)
    /// The CloudKit database (private, public, or shared) to be used.
    ///
    /// - Note: Based on the configuration
    lazy var database = getDatabase()

    // MARK: - Inits
    /// Initializes a new instance of `CDManager` with the specified configuration.
    ///
    /// - Parameter config: The configuration settings to be used by the CloudKit database manager.
    public init(withConfiguration config: CDManagerConfig) {
        self.configuration = config
    }

    // MARK: - Actions
    /// Fetches records of a specified type from the CloudKit database.
    ///
    /// This method fetches records based on the CloudKit database type (private, public, or shared).
    /// - Parameters:
    ///   - recordType: The type of record to fetch.
    ///   - zoneName: The name of the zone to fetch records from. Defaults to `nil`.
    /// - Returns: A dictionary with fetched data.
    /// - Throws: An error if the fetch operation fails.
    public func fetch(recordType: String, fromZoneName zoneName: String? = nil) async throws -> [[String: Any]] {
        try await fetch(recordType: recordType, fromZoneName: zoneName).toDictionary()
    }

    /// Fetches records of a specified type from the CloudKit database.
    ///
    /// This method fetches records based on the CloudKit database type (private, public, or shared).
    /// - Parameters:
    ///   - recordType: The type of record to fetch.
    ///   - zoneName: The name of the zone to fetch records from. Defaults to `nil`.
    /// - Returns: A dictionary with fetched data.
    /// - Throws: An error if the fetch operation fails.
    public func fetch(recordType: String, fromZoneName zoneName: String? = nil) async throws -> [CKRecord] {
        switch configuration.cloudType {
        case .private:
            try await getPrivateRecords(recordType: recordType,
                                        fromZoneName: zoneName)
        case .public:
            []
        case .shared:
            []
        }
    }
}
