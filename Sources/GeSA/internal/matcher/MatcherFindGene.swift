//
//  MatcherFindGene.swift
//  GeSA
//
//  Created by Ilya Mikhaltsou on 20.12.2017.
//

import Foundation
import MicroGene

fileprivate class CompiledExpressions {
    struct BindingInformation {
//        var matchable: Matchable.Type
//        var binding: AnyVariableBinding
    }

    private struct MatchableInformation {
        var type: Matchable.Type
    }

    private var compiledExpressions: PathMatchingTree<BindingInformation> {
        if let c = _compiledExpressions { return c }
        else { compileExpressions() ; return _compiledExpressions! }
    }
    private var _compiledExpressions: PathMatchingTree<BindingInformation>?
    private var allMatchables: [ObjectIdentifier: MatchableInformation]

    public init() {
        _compiledExpressions = PathMatchingTree()
        allMatchables = [:]
    }

    // TODO: Remove double functions when Swift generics work the way they are supposed to
//    public func _register(_ matchableType: Matchable.Type) {
//        _compiledExpressions = nil
//        allMatchables[ObjectIdentifier(matchableType)] = Box(MatchableInformation(type: matchableType, onMatch: matchClosure, partials: [:]))
//    }
//
//    public func register<T>(_ matchableType: T.Type, onMatch matchClosure: @escaping (T) -> ()) where T: Matchable {
//        let typeErasedClosure = { (m: Matchable) -> () in
//            guard let typedM = m as? T else { fatalError("Internal error while restoring type information") }
//            matchClosure(typedM)
//        }
//        _register(matchableType, onMatch: typeErasedClosure)
//    }
//
//    public func registerUntyped(_ matchableType: Matchable.Type, onMatch matchClosure: @escaping (Matchable) -> ()) {
//        _register(matchableType, onMatch: matchClosure)
//    }

    private func compileExpressions() {
//        let allExpressions: [(PathExpression, BindingInformation)] =
//            allMatchables.values.flatMap { m in
//                m.type.bindings.lazy.map { b in
//                    (b.path, BindingInformation(matchable: m.type, binding: b))
//                }
//            }
        let allExpressions: [(PathExpression, BindingInformation)] = []
        _compiledExpressions = PathMatchingTree(expressions: allExpressions)
    }

    func matches(for path: Path, type: AnyStorable.Type) -> [BindingInformation] {
//        let candidateList = compiledExpressions.allExpressions(satisfying: path).lazy
//            .filter { c in c.binding.isCompatible(with: type) }
//            .sorted { (lhv, rhv) -> Bool in
//                if lhv.information.boxed.type.priority == rhv.information.boxed.type.priority {
//                    return lhv.information.boxed.type.bindings.count > rhv.information.boxed.type.bindings.count
//                } else {
//                    return lhv.information.boxed.type.priority > rhv.information.boxed.type.priority
//                }
//        }
//        return candidateList
        return []
    }

}

extension CompiledExpressions: MicroGene.Storable { }

class MatcherFindGene: Gene, RequiresStartupInitialization {
    public static let bindings: [AnyVariableBinding] = [
        PathExpressions.operation <> \MatcherFindGene.operation,
        PathExpressions.compiledExpressions <> \MatcherFindGene.compiledExpressions,
    ]

    public struct Paths {
        public static let compiledExpressions = /.gesa / .components / .matcher / .compiledExpressions
    }

    public struct PathExpressions {
        public static let operation = /.repeating(~/.any) / !.storageOperation
        public static let compiledExpressions = !(Paths.compiledExpressions)
    }

    fileprivate var operation = Var(StorageOperation.self)
    fileprivate var compiledExpressions = Var(CompiledExpressions.self)

    private var path: Path!
    private var value: AnyStorable!
    private var foundBindings: [CompiledExpressions.BindingInformation]!

    public static let priority = Priority.normal

    public required init() { }

    public static func startupHook(store: Storing) {
        store.put(data: CompleteValue(CompiledExpressions()), to: Paths.compiledExpressions)
    }

    public func match() -> Bool {
        guard case let .put(path, value) = operation.value else { return false }

        self.path = path
        self.value = value

        guard operation.state.marker(for: .matcherInhibit) as Bool? == nil else { return false }

        let foundBindings = compiledExpressions.value.matches(for: path, type: type(of: value))

        guard foundBindings.count != 0 else { return false }

        self.foundBindings = foundBindings

        return true
    }

    open func execute() -> [AnyOutput] {
        let matches = foundBindings.map { bi in
            PossibleVariableMatch(
                path: path
//            bi.matchable
//            bi.binding
            )
        }
        operation.state.set(marker: true, for: .matcherInhibit)
        let targetCompartment = operation.path.compartment / MicroGene.CompartmentId(name: "match")
        return [
            MicroGene.Output(value: MatchOrStore(bit: operation.completeValue),
                             to: targetCompartment / .matchOrStore),
        ] + matches.map { m in
            MicroGene.Output(value: m, to: targetCompartment / .possibleVariableMatch)
        }
    }
}

