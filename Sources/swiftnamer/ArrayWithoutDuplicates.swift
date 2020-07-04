//
//  ArrayWithoutDuplicates.swift
//  swiftnamer
//
//  Created by mikel evins on 7/4/20.
//  Copyright © 2020 mikel evins. All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func withoutDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.withoutDuplicates()
    }
}
