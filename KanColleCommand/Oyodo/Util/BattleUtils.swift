//
// Created by CC on 2019-03-17.
// Copyright (c) 2019 CC. All rights reserved.
//

import Foundation

func buildHeadingStr(heading: Int) -> String {
    var result = ""
    switch (heading) {
    case 1:
        result = "同航战"
        break
    case 2:
        result = "反航战"
        break
    case 3:
        result = "T有利"
        break
    case 4:
        result = "T不利"
        break
    default:
        result = "未知航向"
        break
    }
    return result
}

func buildAirCommandStr(air: Int) -> String {
    var result = ""
    switch (air) {
    case 0:
        result = "航空均衡"
        break
    case 1:
        result = "制空确保"
        break
    case 2:
        result = "航空优势"
        break
    case 3:
        result = "航空劣势"
        break
    case 4:
        result = "制空丧失"
        break
    default:
        result = "未知制空"
        break
    }
    return result
}
