//
//  CDManagerFetchError.swift
//
//  Created by Thais Rodríguez on 10/6/24.
//

import Foundation

/// An enumeration representing errors that can occur while fetching data from CloudKit databases in CDManager.
///
/// `CDManagerFetchError` conforms to the `Error` and `LocalizedError` protocols to provide detailed error descriptions
/// that can be used for debugging error messages.
public enum CDManagerFetchError: Error, LocalizedError {
    /// Represents an error that occurs when the public database cannot be fetched.
    case unableToFetchPublicDatabase
    /// Represents an error that occurs when the shared database cannot be fetched.
    case unableToFetchSharedDatabase

    /// Message describing what error occurred.
    ///
    /// This property provides a human-readable error message for each case, which can be useful for debugging and user-facing error messages.
    public var errorDescription: String? {
        switch self {
        case .unableToFetchPublicDatabase: "Unable to fetch the public database."
        case .unableToFetchSharedDatabase: "Unable to fetch the shared database."
        }
    }

    /// Provides a descriptive reason for the failure.
    ///
    /// This property provides a human-readable failure reason message for each case, which can be useful for debugging and user-facing error messages.
    public var failureReason: String? {
        switch self {
        case .unableToFetchPublicDatabase: "Pending the implementation of data collection from a public database."
        case .unableToFetchSharedDatabase: "Pending the implementation of data collection from a shared database."
        }
    }
}
