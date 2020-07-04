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
    return split(contents).withoutDuplicates()
}

func extend_name(_ start:String, _ parts: [String], _ ends: [String]) -> String {
    let candidates = parts.filter(joinableWith(start))
    if let next = candidates.randomElement() {
        // if next is an end then 6/10 of the time we quit with it
        if ((ends.contains(next)) && (Int.random(in: 1..<10) < 6)) {
            return join(left: start, right: next)
        } else {
            let new_start = join(left: start, right: next)
            return extend_name(new_start, parts, ends)
        }
    } else {
        return start
    }
    
}

let usage = """
swiftnamer v0.2

USAGE:
swiftnamer COUNT PATHNAME

Returns a list of COUNT names, generated from the examples in the file PATHNAME.

COUNT must be a positive integer.

PATHNAME must be the path of a text file containing one sample name per line.

"""

if (CommandLine.arguments.count < 3) {
    print(usage)
    exit(1)
} else {
    let name_count = Int(CommandLine.arguments[1])!
    let samples_path = CommandLine.arguments[2]
    let sample_lines = readlines(samples_path)
    let sample_triples = (sample_lines.map { triples(from: $0) }).withoutDuplicates()
    let sample_starts = (sample_triples.map { head($0) }).withoutDuplicates()
    let sample_parts = flatten(tails(sample_triples))
    let sample_ends = (sample_triples.map { end($0) ?? "" }).withoutDuplicates()
    
    var names = [String]()
    while names.count <  name_count {
        let start = any_element(sample_starts) ?? ""
        let nm = extend_name(start, sample_parts, sample_ends)
        if (nm.count>0) && (!names.contains(nm)) {
            names.append(nm)
        }
    }
    
    for name in names {
        print("\(name)")
    }
}
