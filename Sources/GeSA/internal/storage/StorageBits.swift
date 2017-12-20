//
//  StorageBits.swift
//  GeSA
//
//  Created by Ilya Mikhaltsou on 19.12.2017.
//

import Foundation
import MicroGene

enum StorageOperation: MicroGene.Storable {
    case put(path: Path, value: AnyStorable)
//    case takeOne(path: Path, type: AnyStorable.Type)
}

