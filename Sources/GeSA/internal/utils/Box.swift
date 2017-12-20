//
//  Box.swift
//  MicroGene
//
//  Created by Ilya Mikhaltsou on 10/15/17.
//

import Foundation

class Box<T> {
    var boxed: T

    init(_ boxed: T) {
        self.boxed = boxed
    }
}
