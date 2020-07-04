//
//  ListUtils.swift
//  swiftnamer
//
//  Created by mikel evins on 7/3/20.
//  Copyright © 2020 mikel evins. All rights reserved.
//

import Foundation

func split(_ string: String) -> [String] {
    return string.components(separatedBy: "\n")
}

func triple(from: String, at: Int) -> String {
    return from[at..<(at+3 )]
}

func triples(from: String) -> [String] {
    let len = from.count
    if (len<=3) {
        return [from]
    } else {
        let subrange = 0..<(from.count-2)
        return subrange.map { triple(from: from, at: $0) }
    }
}

func head<T> (_ seq: [T]) -> T {
    return seq[0]
}

func tail<T> (_ seq: [T]) -> [T] {
    return Array(seq.dropFirst())
}

func tails<T> (_ seq: [[T]]) -> [[T]] {
    return seq.map { tail($0) }
}

func end<T>(_ seq: [T]) -> T? {
    return seq.last
}


func flatten<T> (_ seq: [[T]]) -> [T] {
    return Array(seq.joined())
}

func any_element<T>(_ elts: [T]) -> T? {
    return elts.randomElement()
}

func joinableWith(_ left: String) -> ((String) -> Bool) {
    return { right in return (left[left.count-2] == right[0]) && (left[left.count-1] == right[1]) }
}

func join(left: String, right: String) -> String {
    return left + right[2..<right.count]
}

