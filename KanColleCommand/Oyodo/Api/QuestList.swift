//
// Created by CC on 2019-03-24.
// Copyright (c) 2019 CC. All rights reserved.
//

import Foundation
import HandyJSON
import RxSwift

class QuestList: JsonBean {

    var api_result: Int = 0
    var api_result_msg: String = ""
    var api_data: QuestListApiData? = QuestListApiData()

    override func process() {
        do {
            let map = try Mission.instance.questMap.value()
            let tabId = parse(value: params["api_tab_id"])
            if (tabId == 9 || !Mission.instance.isSameDay()) {
                map.forEach { key, value in
                    value.state = 1
                }
            }
        } catch {
            print("Got error in QuestList process")
        }
    }

}

class QuestListApiData: HandyJSON {

    var api_count: Int = 0
    var api_completed_kind: Int = 0
    var api_page_count: Int = 0
    var api_disp_page: Int = 0
    var api_list = Array<String>()
    var api_exec_count: Int = 0
    var api_exec_type: Int = 0

    required init() {

    }

}

class QuestListBean: HandyJSON {

    var api_no: Int = 0
    var api_category: Int = 0
    var api_type: Int = 0
    var api_state: Int = 0
    var api_title: String = ""
    var api_detail: String = ""
    var api_voice_id: Int = 0
    var api_get_material = Array<Int>()
    var api_bonus_flag: Int = 0
    var api_progress_flag: Int = 0
    var api_invalid_flag: Int = 0

    required init() {

    }

}
