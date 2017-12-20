//
//  CompiledExpressionMatching.swift
//  MicroGene
//
//  Created by Ilya Mikhaltsou on 10/15/17.
//

import Foundation

struct CompiledExpressionBox<T> {
    var list: [T]

    init(_ list: [T]) {
        self.list = list
    }
}

protocol CompiledExpressionMatching {
    associatedtype Match
    associatedtype Result

    func match(_ value: Match) -> [Result]
}

protocol CompiledPartialExpressionMatching {
    associatedtype Match
    associatedtype Result

    func match(_ value: Match) -> [(Match, Result)]
}

struct CompiledCompartmentExpression<T> {
    var node: [CompartmentId: CompiledCompartmentExpression<T>]
    var staticRepeatingPartials: [CompartmentPartialExpression: CompiledCompartmentExpression<T>]
    var root: CompiledExpressionBox<T>

    var anyNode: Box<CompiledCompartmentExpression<T>?>

    fileprivate init() {
        self.node = [:]
        self.staticRepeatingPartials = [:]
        self.root = CompiledExpressionBox([])
        self.anyNode = Box(nil)
    }
}

struct CompiledPathExpression<T> {
    var storable: [StorableId: CompiledCompartmentExpression<T>]
    var any: Box<CompiledCompartmentExpression<T>?>

    fileprivate init() {
        self.storable = [:]
        self.any = Box(nil)
    }
}

extension CompiledCompartmentExpression: CompiledExpressionMatching {
    typealias Match = CompartmentIndex
    typealias Result = CompiledExpressionBox<T>

    func match(_ compartment: CompartmentIndex) -> [CompiledExpressionBox<T>] {
        var result: [CompiledExpressionBox<T>] = []

        guard case let .node(otherId, parent) = compartment else { return [root] }

        result.append(contentsOf: node[otherId]?.match(parent) ?? [])
        result.append(contentsOf: anyNode.boxed?.match(parent) ?? [])

        for (partial, parentExpression) in staticRepeatingPartials {
            var lastSuccess: CompartmentIndex? = compartment
            while let compartment = lastSuccess {
                let newIndex = partial.match(compartment)
                if let r = newIndex {
                    result.append(contentsOf: parentExpression.match(r))
                }
                lastSuccess = newIndex
            }
        }

        return result
    }
}

extension CompiledPathExpression: CompiledExpressionMatching {
    typealias Match = Path
    typealias Result = CompiledExpressionBox<T>

    func match(_ path: Path) -> [CompiledExpressionBox<T>] {
        var result: [CompiledExpressionBox<T>] = []

        result.append(contentsOf: storable[path.storable]?.match(path.compartment) ?? [])
        result.append(contentsOf: any.boxed?.match(path.compartment) ?? [])

        return result
    }
}

extension CompiledCompartmentExpression {
    fileprivate mutating func _add(compartmentExpression: CompartmentExpression, with value: T) {
        switch compartmentExpression {
        case let .node(.any, parent: parentExpression):
            if anyNode.boxed == nil { anyNode.boxed = CompiledCompartmentExpression() }
            anyNode.boxed?._add(compartmentExpression: parentExpression, with: value)
        case let .node(.id(id), parent: parentExpression):
            if node[id] == nil { node[id] = CompiledCompartmentExpression() }
            node[id]?._add(compartmentExpression: parentExpression, with: value)
        case let .root(.node(id, parent: parent)):
            if node[id] == nil { node[id] = CompiledCompartmentExpression() }
            node[id]?._add(compartmentExpression: .root(parent), with: value)
        case .root(.root):
            root.list.append(value)
        case let .repeating(expression: partial, parent: parentExpression):
            if staticRepeatingPartials[partial] == nil { staticRepeatingPartials[partial] = CompiledCompartmentExpression() }
            staticRepeatingPartials[partial]?._add(compartmentExpression: parentExpression, with: value)
        }
    }
}

extension CompiledPathExpression {
    fileprivate mutating func _add(pathExpression: PathExpression, with value: T) {
        switch pathExpression {
        case let .or(one, two):
            _add(pathExpression: one, with: value)
            _add(pathExpression: two, with: value)
        case let .single(.any, compartmentExpression):
            if any.boxed == nil { any.boxed = CompiledCompartmentExpression() }
            any.boxed?._add(compartmentExpression: compartmentExpression, with: value)
        case let .single(.id(id), compartmentExpression):
            if storable[id] == nil { storable[id] = CompiledCompartmentExpression() }
            storable[id]?._add(compartmentExpression: compartmentExpression, with: value)
        }
    }
}

struct PathMatchingTree<T> {
    var compiledPathExpression: CompiledPathExpression<T>

    init() {
        compiledPathExpression = CompiledPathExpression()
    }

    init(expressions: [(PathExpression, T)]) {
        compiledPathExpression = CompiledPathExpression()
        for (expression, value) in expressions {
            self.add(pathExpression: expression, with: value)
        }
    }

    mutating func add(pathExpression: PathExpression, with value: T) {
        compiledPathExpression._add(pathExpression: pathExpression, with: value)
    }

    func allExpressions(satisfying path: Path) -> [T] {
        let compiled = compiledPathExpression.match(path)
        return compiled.flatMap { c in c.list}
    }
}

