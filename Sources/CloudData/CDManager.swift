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
    public func fetch(recordType: String, fromZoneName zoneName: String) async throws -> [String: String] {
        var recipes: [String: String] = [:]
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))

        let result = try await database.records(matching: query,
                                                inZoneWith: CKRecordZone(zoneName: zoneName).zoneID,
                                                desiredKeys: nil)
        let records = result.matchResults.compactMap { $0.1.get }

        do {
            try records.forEach { dataClosure in
                let record = try dataClosure()
                recipes[record.recordID.recordName] = record["name"]
            }
            
            return recipes
        } catch {
            throw error
        }
    }
}
