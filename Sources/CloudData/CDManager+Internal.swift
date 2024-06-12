//
//  CDManager+Internal.swift
//
//
//  Created by Thais Rodríguez on 9/6/24.
//

import CloudKit

/// Internal extension of ``CDManager``
extension CDManager {
    /// Determines and returns the appropriate CloudKit database based on the configuration.
    ///
    /// - Returns: The CloudKit database (private, public, or shared) as specified in the configuration.
    func getDatabase() -> CKDatabase {
        switch configuration.cloudType {
        case .private: container.privateCloudDatabase
        case .public: container.publicCloudDatabase
        case .shared: container.sharedCloudDatabase
        }
    }

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

    func getPublicRecords() -> [String: String] {
        [:]
    }

    func getSharedRecords() -> [String: String] {
        [:]
    }
}
