//
//  BasicMemoryStorageGene.swift
//  GeSA
//
//  Created by Ilya Mikhaltsou on 19.12.2017.
//

import Foundation
import MicroGene

fileprivate class ActualStorage {
    init() { }
}

extension ActualStorage: MicroGene.Storable {
}

public class BasicMemoryStorageGene: MicroGene.Gene {
    public static let bindings: [AnyVariableBinding] = [
        !(/.gesa / .components / .storage) / !.actualStorage  <> \BasicMemoryStorageGene.storage
    ]

    fileprivate var storage = Var(ActualStorage.self)

    public static let priority = Priority.normal

    public required init() { }

    public func match() -> Bool {
        return true
    }

    open func execute() -> [AnyOutput] {
        return []
    }
}
