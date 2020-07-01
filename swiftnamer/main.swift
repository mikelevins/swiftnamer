//
//  main.swift
//  swiftnamer
//
//  Created by mikel evins on 6/30/20.
//  Copyright © 2020 mikel evins. All rights reserved.
//

import Foundation

func readlines(_ pathname: String) -> [String] {
    let contents = try! String(contentsOfFile: pathname)
    let lines = contents.components(separatedBy: "\n")
    let filtered_lines = lines.filter { $0.count > 2 }
    return filtered_lines
}

func triple(from: String, at: Int) -> String {
    let startIndex = from.index(from.startIndex, offsetBy: at)
    let endIndex = from.index(from.startIndex, offsetBy: at+3)
    let range = Range(uncheckedBounds: (lower: startIndex, upper: endIndex))
    let letters = String(from[range])
    return letters
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

let args = CommandLine.arguments
let samples_path = args[1]
let sample_lines = readlines(samples_path)
let sample_triples = sample_lines.map { triples(from: $0) }
let sample_starts = sample_triples.map { $0[0] }
let sample_parts = sample_triples.map { Array($0.dropFirst()) }

for parts in sample_parts {
    print("\(parts)")
}
