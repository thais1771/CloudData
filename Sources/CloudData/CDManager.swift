//
//  CDManager.swift
//
//  Created by Thais Rodríguez on 9/6/24.
//

import CloudKit

/// A class to manage interactions with a CloudKit database.
public class CDManager: ObservableObject {
    // MARK: - Properties
    /// Configuration settings for the CloudKit database manager.
    private let config: CDConfig

    // MARK: CloudKit Properties
    /// The CloudKit container used to manage CloudKit interactions.
    ///
    /// - Note: Based on the configuration
    private lazy var container = CKContainer(identifier: config.containerIdentifier)
    /// The CloudKit database (private, public, or shared) to be used.
    ///
    /// - Note: Based on the configuration
    private lazy var database = getDatabase()

    // MARK: - Inits
    /// Initializes a new instance of `CDManager` with the specified configuration.
    ///
    /// - Parameter config: The configuration settings to be used by the CloudKit database manager.
    public init(config: CDConfig) {
        self.config = config
    }
}

private extension CDManager {
    /// Determines and returns the appropriate CloudKit database based on the configuration.
    ///
    /// - Returns: The CloudKit database (private, public, or shared) as specified in the configuration.
    func getDatabase() -> CKDatabase {
        switch config.cloudType {
        case .private: container.privateCloudDatabase
        case .public: container.publicCloudDatabase
        case .shared: container.sharedCloudDatabase
        }
    }
}
