//
//  HashCombine.swift
//  GeSA
//
//  Created by Ilya Mikhaltsou on 15.12.2017.
//

import Foundation

fileprivate let MAGIC_COMBINATION_VALUE = 0x517cc1b727220a95

func hashCombine(lhv: Int, rhv: Int) -> Int {
    // Lifted from boost:hash_combine
    return lhv ^ (rhv &+ MAGIC_COMBINATION_VALUE &+ (lhv << 6) &+ (lhv >> 2))
}
