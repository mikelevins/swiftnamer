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
    return split(contents)
}

func joinable(left: String, right: String) -> Bool {
    return (left[left.count-2] == right[0]) && (left[left.count-1] == right[1])
}

func join(left: String, right: String) -> String {
    return left + right[2..<right.count]
}

func extend_name(_ start:String, _ parts: [String], _ ends: [String]) -> String {
    let candidates = parts.filter { joinable(left: start, right: $0) }
    if let next = candidates.randomElement() {
        // if next is an end then two thirds of the time we quit with it
        if ((ends.contains(next)) && (Int.random(in: 1..<10) < 7)) {
            return join(left: start, right: next)
        } else {
            let new_start = join(left: start, right: next)
            return extend_name(new_start,parts, ends)
        }
    } else {
        return start
    }
    
}

if (CommandLine.arguments.count < 3) {
    print("""
    swiftnamer v0.2

    USAGE:
      swiftnamer COUNT PATHNAME

    Returns a list of COUNT names, generated from the examples in the file PATHNAME.

    COUNT must be a positive integer.

    PATHNAME must be the path of a text file containing one sample name per line.

    """)
    
    exit(1)

} else {
    let name_count = Int(CommandLine.arguments[1])!
    let samples_path = CommandLine.arguments[2]
    let sample_lines = readlines(samples_path)
    let sample_triples = sample_lines.map { triples(from: $0) }
    let sample_starts = sample_triples.map { head($0) }
    let sample_parts = flatten(tails(sample_triples))
    let sample_ends = sample_triples.map { end($0) ?? "" }
    
    var names = [String]()
    for _ in 0..<name_count {
        let start = any_element(sample_starts) ?? ""
        names.append(extend_name(start, sample_parts, sample_ends))
    }
    
    for name in names {
        print("\(name)")
    }
}
