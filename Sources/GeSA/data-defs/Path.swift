//
//  Path.swift
//  GeSA
//
//  Created by Ilya Mikhaltsou on 15.12.2017.
//

import Foundation

public struct Path {
    var storable: StorableId
    var compartment: CompartmentIndex
}

extension Path: Equatable {
    public static func == (lhv: Path, rhv: Path) -> Bool {
        guard lhv.storable == rhv.storable else { return false }
        guard lhv.compartment == rhv.compartment else { return false }
        return true
    }
}

extension Path: Hashable {
    public var hashValue: Int {
        return hashCombine(lhv: storable.hashValue, rhv: compartment.hashValue)
    }
}

public func / (lhv: CompartmentIndex, rhv: StorableId) -> Path {
    return Path(storable: rhv, compartment: lhv)
}

extension Path: CustomStringConvertible {
    public var description: String {
        return "\(compartment) \(storable)"
    }
}
