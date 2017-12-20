//
//  CompartmentIndex.swift
//  GeSA
//
//  Created by Ilya Mikhaltsou on 15.12.2017.
//

import Foundation

public enum CompartmentIndex {
    case root
    indirect case node(id: CompartmentId, parent: CompartmentIndex)
}

extension CompartmentIndex: Equatable {
    public static func == (lhv: CompartmentIndex, rhv: CompartmentIndex) -> Bool {
        switch (lhv, rhv) {
        case (.root, .root):
            return true
        case let (.node(lid, lparent), .node(rid, rparent)):
            return lid == rid && lparent == rparent
        default:
            return false
        }
    }
}

fileprivate let MAGIC_ROOT_VALUE = 9992888331

extension CompartmentIndex: Hashable {
    public var hashValue: Int {
        switch self {
        case .root:
            return MAGIC_ROOT_VALUE
        case let .node(id, parent):
            return hashCombine(lhv: id.hashValue, rhv: parent.hashValue)
        }
    }
}

extension CompartmentId {
    public static prefix func / (_ id: CompartmentId) -> CompartmentIndex {
        return .node(id: id, parent: CompartmentIndex.root)
    }
}

extension CompartmentIndex {
    public static func / (lhv: CompartmentIndex, rhv: CompartmentId) -> CompartmentIndex {
        return .node(id: rhv, parent: lhv)
    }
}

extension CompartmentIndex: CustomStringConvertible {
    public var description: String {
        switch self {
        case let .node(id, parent):
            return "\(parent) \(id) /"
        case .root:
            return "/"
        }
    }
}
