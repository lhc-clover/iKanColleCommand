//
// Created by CC on 2019-02-26.
// Copyright (c) 2019 CC. All rights reserved.
//

import Foundation

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Dictionary {
    subscript(safe key: Key) -> Value? {
        return keys.contains(key) ? self[key] : nil
    }
}

func parse(value: String?) -> Int {
    if let str = value, let parsedInt = Int(str) {
        return parsedInt
    } else {
        return -1
    }
}
