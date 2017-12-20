//
//  MatcherBits.swift
//  GeSA
//
//  Created by Ilya Mikhaltsou on 20.12.2017.
//

import Foundation
import MicroGene

struct MatchOrStore: MicroGene.Storable {
    var bit: MicroGene.CompleteValue<StorageOperation>
}

struct PossibleVariableMatch: MicroGene.Storable {
//    var matchable: Matchable
//    var variableBinding: AnyVariableBinding
    var path: Path
}

