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
    return lines
}


let args = CommandLine.arguments
let lines = readlines("/Users/mikel/Workshop/src/swiftnamer/data/gnome.names")
for line in lines {
    print("\(line)")
}
print("Command line arguments: ", args)
