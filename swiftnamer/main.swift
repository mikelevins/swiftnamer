//
//  main.swift
//  swiftnamer
//
//  Created by mikel evins on 6/30/20.
//  Copyright © 2020 mikel evins. All rights reserved.
//

import Foundation

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

func readlines(_ pathname: String) -> [String] {
    let contents = try! String(contentsOfFile: pathname)
    let lines = contents.components(separatedBy: "\n")
    let filtered_lines = lines.filter { $0.count > 2 }
    return filtered_lines
}

func triple(from: String, at: Int) -> String {
    return from[at..<(at+3 )]
}

func triples(from: String) -> [String] {
    let charcount = from.count
    let subrange = 0..<(charcount-2)
    return subrange.map {
        triple(from: from, at: $0)
    }
}

func starts(_ trips: [[String]]) -> [String] {
    return trips.map { $0[0] }
}

func tails(_ trips: [[String]]) -> [[String]] {
    return trips.map { Array($0.dropFirst()) }
}

func joinable(left: String, right: String) -> Bool {
    let leftcount = left.count
    return (left[leftcount-2] == right[0]) && (left[leftcount-1] == right[1])
}

func join(left: String, right: String) -> String {
    let rightlen = right.count
    return left + right[2..<rightlen]
}

let args = CommandLine.arguments
let samples_path = args[1]
let sample_lines = readlines(samples_path)
let sample_triples = sample_lines.map { triples(from: $0) }
let sample_starts = starts(sample_triples)
let sample_tails = tails(sample_triples)

print("\(sample_starts.randomElement()!)")
let bar = "Bar"
let arney = "arney"
print("\(join(left: bar, right: arney))")
