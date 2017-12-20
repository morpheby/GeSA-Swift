//
//  SystemPaths.swift
//  GeSA
//
//  Created by Ilya Mikhaltsou on 15.12.2017.
//

import Foundation
import MicroGene

extension MicroGene.CompartmentId {
    static let gesa = MicroGene.CompartmentId(name: "GeSA" + locallyUniqueId())
    static let components = MicroGene.CompartmentId(name: "components")
    static let storage = MicroGene.CompartmentId(name: "storage")
}

extension MicroGene.StorableId {
    static let storageOperation = MicroGene.StorableId(name: "operation")
    static let actualStorage = MicroGene.StorableId(name: "actualStorage")
}
