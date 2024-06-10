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
    public func fetch(recordType: String, fromZoneName zoneName: String? = nil) async throws -> [String: String] {
        switch configuration.cloudType {
        case .private:
            try await getPrivateRecords(recordType: recordType,
                                        fromZoneName: zoneName)
        case .public:
            ["data": "No data"]
        case .shared:
            ["data": "No data"]
        }
    }
}
