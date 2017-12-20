//
//  PathExpression.swift
//  MicroGene
//
//  Created by Ilya Mikhaltsou on 10/13/17.
//

import Foundation

public enum StorableExpression {
    case any
    case id(StorableId)
}

public enum CompartmentIdExpression {
    case any
    case id(CompartmentId)
}

public enum CompartmentPartialExpression {
    indirect case node(CompartmentIdExpression, parent: CompartmentPartialExpression)
    case root(CompartmentIdExpression)
}

public enum CompartmentRepeatingExpression {
    case repeating(CompartmentPartialExpression)
}

public enum CompartmentExpression {
    indirect case node(CompartmentIdExpression, parent: CompartmentExpression)
    indirect case repeating(expression: CompartmentPartialExpression, parent: CompartmentExpression)
    case root(CompartmentIndex)
}

public enum PathExpression {
    indirect case or(PathExpression, PathExpression)
    case single(storable: StorableExpression, compartment: CompartmentExpression)
}

extension CompartmentId {
    public static prefix func ! (_ value: CompartmentId) -> CompartmentIdExpression {
        return .id(value)
    }
}

extension StorableId {
    public static prefix func ! (_ value: StorableId) -> StorableExpression {
        return .id(value)
    }
}

extension CompartmentIndex {
    public static prefix func ! (_ value: CompartmentIndex) -> CompartmentExpression {
        return .root(value)
    }
}

extension CompartmentIdExpression {
    public static prefix func / (_ value: CompartmentIdExpression) -> CompartmentExpression {
        return .node(value, parent: .root(.root))
    }

    public static prefix func ~/ (_ value: CompartmentIdExpression) -> CompartmentPartialExpression {
        return .root(value)
    }
}

extension Path {
    public static prefix func ! (_ value: Path) -> PathExpression {
        return .single(storable: .id(value.storable), compartment: .root(value.compartment))
    }
}

extension CompartmentExpression {
    public static func / (lhv: CompartmentExpression, rhv: CompartmentIdExpression) -> CompartmentExpression {
        return .node(rhv, parent: lhv)
    }

    public static func / (lhv: CompartmentExpression, rhv: CompartmentRepeatingExpression) -> CompartmentExpression {
        guard case let .repeating(value) = rhv else { fatalError("Unsupported enum (somehow)") }
        return .repeating(expression: value, parent: lhv)
    }

    public static func / (lhv: CompartmentExpression, rhv: StorableExpression) -> PathExpression {
        return .single(storable: rhv, compartment: lhv)
    }
}

extension CompartmentRepeatingExpression {
    public static prefix func / (_ value: CompartmentRepeatingExpression) -> CompartmentExpression {
        guard case let .repeating(v) = value else { fatalError("Unsupported enum (somehow)") }
        return .repeating(expression: v, parent: .root(.root))
    }
}

extension CompartmentPartialExpression {
    public static func / (lhv: CompartmentPartialExpression, rhv: CompartmentIdExpression) -> CompartmentPartialExpression {
        return .node(rhv, parent: lhv)
    }
}

extension PathExpression {
    public static func || (lhv: PathExpression, rhv: PathExpression) -> PathExpression {
        return .or(lhv, rhv)
    }
}

extension CompartmentIdExpression: Equatable {
    public static func == (lhv: CompartmentIdExpression, rhv: CompartmentIdExpression) -> Bool {
        switch (lhv, rhv) {
        case (.any, .any):
            return true
        case let (.id(lid), .id(rid)) where lid == rid:
            return true
        default:
            return false
        }
    }
}

extension CompartmentIdExpression: Hashable {
    public var hashValue: Int {
        switch self {
        case .any:
            return 8798785679
        case let .id(id):
            return id.hashValue
        }
    }
}

extension CompartmentPartialExpression: Equatable {
    public static func == (lhv: CompartmentPartialExpression, rhv: CompartmentPartialExpression) -> Bool {
        switch (lhv, rhv) {
        case let (.node(lid, lpartial), .node(rid, rpartial)) where lid == rid && lpartial == rpartial:
            return true
        case let (.root(lidx), .root(ridx)) where lidx == ridx:
            return true
        default:
            return false
        }
    }
}

extension CompartmentPartialExpression: Hashable {
    public var hashValue: Int {
        switch self {
        case let .node(id, parent: partial):
            return hashCombine(lhv: id.hashValue, rhv: partial.hashValue)
        case let .root(id):
            return id.hashValue
        }
    }
}

extension StorableExpression: CustomStringConvertible {
    public var description: String {
        switch self {
        case .any:
            return "*"
        case let .id(id):
            return String(describing: id)
        }
    }
}

extension CompartmentIdExpression: CustomStringConvertible {
    public var description: String {
        switch self {
        case .any:
            return "*"
        case let .id(id):
            return String(describing: id)
        }
    }
}

extension CompartmentPartialExpression: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .node(id, parent):
            return "\(parent) \(id) /"
        case let .root(id):
            return "~/ \(id) /"
        }
    }
}

extension CompartmentExpression: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .node(id, parent):
            return "\(parent) \(id) /"
        case let .repeating(partial, parent):
            return "\(parent) Repeating(\(partial)) /"
        case let .root(compartment):
            return "\(compartment)"
        }
    }
}

extension PathExpression: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .or(left, right):
            return "\(left) || \(right)"
        case let .single(storable: storableExpr, compartment: compartmentExpr):
            return "\(compartmentExpr) \(storableExpr)"
        }
    }
}
