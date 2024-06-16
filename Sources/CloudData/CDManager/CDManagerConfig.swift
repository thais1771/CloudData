//
//  CDManagerConfig.swift
//
//  Created by Thais Rodríguez on 9/6/24.
//

/// A structure that defines the configuration settings for `CDManager`.
///
/// `CDManagerConfig` is used to specify the CloudKit container identifier and the type of database to use.
public struct CDManagerConfig {
    /// The identifier of the CloudKit container.
    let containerIdentifier: String
    /// The type of CloudKit database to use (private, public, or shared).
    let cloudType: CDManagerConfig.DataBaseType
    
    /// An enumeration representing the types of databases available in CloudKit.
    public enum DataBaseType {
        /// Represents the private database in CloudKit.
        case `private`
        /// Represents the public database in CloudKit.
        case `public`
        /// Represents the shared database in CloudKit.
        case shared
    }
    
    /// Initializes a new instance of `CDManagerConfig` with the specified container identifier and database type.
    ///
    /// - Parameters:
    ///   - containerIdentifier: The identifier of the CloudKit container.
    ///   - cloudType: The type of CloudKit database to use.
    public init(containerIdentifier: String,
                cloudType: CDManagerConfig.DataBaseType) {
        self.containerIdentifier = containerIdentifier
        self.cloudType = cloudType
    }
}
