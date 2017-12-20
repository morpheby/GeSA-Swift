//
//  SystemPaths.swift
//  GeSA
//
//  Created by Ilya Mikhaltsou on 15.12.2017.
//

import Foundation
import MicroGene

extension MicroGene.CompartmentId {
    static let gesa = MicroGene.CompartmentId(name: "GeSA")
    static let components = MicroGene.CompartmentId(name: "components")
    static let storage = MicroGene.CompartmentId(name: "storage")
    static let matcher = MicroGene.CompartmentId(name: "matcher")
}

extension MicroGene.StorableId {
    static let storageOperation = MicroGene.StorableId(name: "operation")
    static let actualStorage = MicroGene.StorableId(name: "actualStorage")
    static let compiledExpressions = MicroGene.StorableId(name: "compiledExpressions")
    static let matchOrStore = MicroGene.StorableId(name: "matchOrStore")
    static let possibleVariableMatch = MicroGene.StorableId(name: "possibleVariableMatch")
}


extension MicroGene.MarkerId {
    static let matcherInhibit = MicroGene.MarkerId(name: "Matcher::inhibit")
}
