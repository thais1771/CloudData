//
//  CDConfig.swift
//
//  Created by Thais Rodríguez on 9/6/24.
//

// TODO: Documentation
public struct CDConfig {
    let containerIdentifier: String
    let cloudType: CDConfig.DataBaseType
    let zone: String? = nil

    public enum DataBaseType {
        case `private`
        case `public`
        case shared
    }
}
