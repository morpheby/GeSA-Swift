//
//  PathExpressionMatching.swift
//  MicroGene
//
//  Created by Ilya Mikhaltsou on 10/15/17.
//

import Foundation

protocol ExpressionMatching {
    associatedtype Match
    func match(_ value: Match) -> Bool
}

protocol PartialExpressionMatching {
    associatedtype Match
    func match(_ value: Match) -> Match?
}

extension StorableExpression: ExpressionMatching {
    typealias Match = StorableId

    public func match(_ value: StorableId) -> Bool {
        switch (self, value) {
        case (.any, _):
            return true
        case let (.id(thisId), otherId) where thisId == otherId:
            return true
        default:
            return false
        }
    }
}

extension CompartmentIdExpression: ExpressionMatching {
    typealias Match = CompartmentId

    public func match(_ value: CompartmentId) -> Bool {
        switch (self, value) {
        case (.any, _):
            return true
        case let (.id(thisId), otherId) where thisId == otherId:
            return true
        default:
            return false
        }
    }
}

extension CompartmentPartialExpression: PartialExpressionMatching {
    typealias Match = CompartmentIndex

    public func match(_ value: CompartmentIndex) -> CompartmentIndex? {
        switch (self, value) {
        case let (.node(thisId, parent), .node(otherId, compartmentParent)) where thisId.match(otherId):
            return parent.match(compartmentParent)
        case let (.root(thisId), .node(otherId, compartmentParent)) where thisId.match(otherId):
            return compartmentParent
        default:
            return nil
        }
    }
}

extension CompartmentExpression: ExpressionMatching {
    typealias Match = CompartmentIndex

    public func match(_ value: CompartmentIndex) -> Bool {
        switch (self, value) {
        case let (.node(thisId, parent), .node(otherId, compartmentParent)) where thisId.match(otherId):
            return parent.match(compartmentParent)
        case let (.repeating(partial, parent), value):
            var lastSuccess: CompartmentIndex? = value
            while let compartment = lastSuccess {
                let result = partial.match(compartment)
                if let r = result {
                    if parent.match(r) {
                        return true
                    }
                }
                lastSuccess = result
            }
            return false
        case let (.root(thisCompartment), otherCompartment) where thisCompartment == otherCompartment:
            return true
        default:
            return false
        }
    }
}

extension PathExpression: ExpressionMatching {
    typealias Match = Path

    public func match(_ value: Path) -> Bool {
        switch (self, value) {
        case let (.or(one, two), path):
            return one.match(path) || two.match(path)
        case let (.single(storableExpr, compartmentExpr), path) where storableExpr.match(path.storable):
            return compartmentExpr.match(path.compartment)
        default:
            return false
        }
    }
}
