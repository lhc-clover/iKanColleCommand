//
// Created by CC on 2019-02-13.
// Copyright (c) 2019 CC. All rights reserved.
//

import Foundation

class Quest {

    var id: Int = 0
    var title: String = ""
    var state: Int = 0
    var category: Int = 0
    var current: Int = 0
    var max: Int = 0
    var description: String = ""
    var type: MissionRequireType = .NONE

    init(bean: QuestListBean?) {
        if let bean = bean {
            id = bean.api_no
            title = bean.api_title
            state = bean.api_state
            category = bean.api_category
        }
    }

}
