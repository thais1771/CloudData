//
//  CDConfig.swift
//
//  Created by Thais Rodríguez on 9/6/24.
//

// TODO: Documentation
public struct CDManagerConfig {
    let containerIdentifier: String
    let cloudType: CDManagerConfig.DataBaseType
    
    public enum DataBaseType {
        case `private`
        case `public`
        case shared
    }
    
    public init(containerIdentifier: String,
                cloudType: CDManagerConfig.DataBaseType) {
        self.containerIdentifier = containerIdentifier
        self.cloudType = cloudType
    }
}
