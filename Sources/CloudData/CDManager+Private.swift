//
//  File.swift
//
//
//  Created by Thais Rodríguez on 9/6/24.
//

import CloudKit

extension CDManager {
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
