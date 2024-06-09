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
    let config: CDConfig

    // MARK: CloudKit Properties
    /// The CloudKit container used to manage CloudKit interactions.
    ///
    /// - Note: Based on the configuration
    private lazy var container = CKContainer(identifier: config.containerIdentifier)
    /// The CloudKit database (private, public, or shared) to be used.
    ///
    /// - Note: Based on the configuration
    private lazy var database = getDatabase()
    private lazy var zone: CKRecordZone = .init(zoneName: config.zone)

    // MARK: - Inits
    /// Initializes a new instance of `CDManager` with the specified configuration.
    ///
    /// - Parameter config: The configuration settings to be used by the CloudKit database manager.
    public init(config: CDConfig) {
        self.config = config
    }

    // MARK: - Actions
    /// Fetches record zone changes from the CloudKit database.
    ///
    /// The `recordZoneChanges` function can return multiple consecutive changesets before completing.
    /// This method processes multiple results if needed, as indicated by the `moreComing` flag.
    public func fetch() async throws -> [String: String] {
        /// `recordZoneChanges` can return multiple consecutive changesets before completing, so we use a loop to process multiple results if needed, indicated by the `moreComing` flag.
        var awaitingChanges = true
        var recipes: [String: String] = [:]

        // Loop to fetch multiple changesets if needed.
        while awaitingChanges {
            // Fetch changes from the specified record zone since the last change token (nil in this case).
            let data = try await database.recordZoneChanges(inZoneWith: zone.zoneID, since: nil)
            let records = data.modificationResultsByID.compactMapValues { try? $0.get().record }
            let changedRecordIDsAndNames: [(String, String?)] = records.map { id, record in (id.recordName, record["name"]) }

            changedRecordIDsAndNames.forEach { id, name in
                guard let name else { return }
                recipes[id] = name
            }

            // Update `awaitingChanges` based on whether there are more changes to come.
            awaitingChanges = data.moreComing
        }
        
        return recipes
    }
}
