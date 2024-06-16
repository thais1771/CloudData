//
//  CDManager+Internal.swift
//
//
//  Created by Thais Rodríguez on 9/6/24.
//

import CloudKit

extension CDManager {
    /// Determines the appropriate `CloudKit` database based on the configuration.
    ///
    /// - Returns: A `CKDatabase` instance corresponding to the configured database type.
    func getDatabase() -> CKDatabase {
        switch configuration.cloudType {
        case .private:
            return container.privateCloudDatabase
        case .public:
            return container.publicCloudDatabase
        case .shared:
            return container.sharedCloudDatabase
        }
    }

    /// Fetches private `CloudKit` records of a specified type from a specified zone.
    ///
    /// - Parameters:
    ///   - recordType: The type of records to fetch.
    ///   - zoneName: The name of the zone to fetch records from. Defaults to `nil`.
    /// - Returns: An array of `CKRecord` objects representing the fetched records.
    /// - Throws: An error if the fetch operation fails.
    func getPrivateRecords(recordType: String, fromZoneName zoneName: String? = nil) async throws -> [CKRecord] {
        let query = CKQuery(recordType: recordType, predicate: NSPredicate(value: true))
        let zone = zoneName != nil ? CKRecordZone(zoneName: zoneName!) : nil

        let result = try await database.records(matching: query,
                                                inZoneWith: zone?.zoneID,
                                                desiredKeys: nil)

        let records = result.matchResults.compactMap { result in
            result.1.get
        }

        do {
            return try records.map { try $0() }
        } catch {
            throw error
        }
    }

    /// Fetches public `CloudKit` records.
    ///
    /// - Important: Make documentation when method implemented / developed.
    fileprivate func getPublicRecords() -> [String: String] {
        return [:]
    }

    /// Fetches shared `CloudKit` records.
    ///
    /// - Important: Make documentation when method implemented / developed.
    fileprivate func getSharedRecords() -> [String: String] {
        return [:]
    }
}

extension Array where Element == CKRecord {
    /// Converts an array of `CKRecord` objects into an array of dictionaries.
    ///
    /// - Returns: An array of dictionaries, where each dictionary represents a `CKRecord`'s key-value pairs.
    func toDictionary() -> [[String: Any]] {
        self.compactMap {
            $0.dictionaryWithValues(forKeys: $0.allKeys())
        }
    }
}
