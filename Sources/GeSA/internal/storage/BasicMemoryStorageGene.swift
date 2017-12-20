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

    func put(value: AnyStorable, at path: Path) {
        debugPrint("Hello from actual storage: put \(value) at \(path)")
    }
}

extension ActualStorage: MicroGene.Storable {
}

public class BasicMemoryStorageGene: MicroGene.Gene, MicroGene.RequiresStartupInitialization {

    public static let bindings: [AnyVariableBinding] = [
        PathExpressions.storage  <> \BasicMemoryStorageGene.storage,
        PathExpressions.operation <> \BasicMemoryStorageGene.operation,
    ]

    public struct Paths {
        public static let storage = /.gesa / .components / .storage / .actualStorage
    }

    public struct PathExpressions {
        public static let storage = !(Paths.storage)
        public static let operation = /.repeating(~/.any) / !.storageOperation
    }

    fileprivate var storage = Var(ActualStorage.self)
    fileprivate var operation = Var(StorageOperation.self)

    public static let priority = Priority.normal

    public required init() { }

    public static func startupHook(store: MicroGene.Storing) {
        store.put(data: CompleteValue(ActualStorage()), to: Paths.storage)
    }

    public func match() -> Bool {
        return true
    }

    open func execute() -> [AnyOutput] {
        switch operation.value {
        case let .put(path, value):
            storage.value.put(value: value, at: path)
            return []
        }
    }
}
