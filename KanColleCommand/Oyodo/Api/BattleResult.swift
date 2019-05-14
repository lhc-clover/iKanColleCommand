//
// Created by CC on 2019-03-16.
// Copyright (c) 2019 CC. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON

class IBattleResult<T: IBattleResultApiData>: JsonBean {

    var api_result: Int = 0
    var api_result_msg: String = ""
    var api_data: T?

    required init() {

    }

}

class IBattleResultApiData: HandyJSON {

    var api_ship_id = Array<Int>()
    var api_win_rank: String?
    var api_get_exp: Int = 0
    var api_mvp: Int = 0
    var api_member_lv: Int = 0
    var api_member_exp: Int = 0
    var api_get_base_exp: Int = 0
    var api_get_ship_exp = Array<Int>()
    var api_get_exp_lvup = Array<Array<Int>>()
    var api_dests: Int = 0
    var api_destsf: Int = 0
    var api_quest_name: String = ""
    var api_quest_level: Int = 0
    var api_enemy_info: ApiEnemyInfo? = ApiEnemyInfo()
    var api_first_clear: Int = 0
    var api_mapcell_incentive: Int = 0
    var api_get_flag = Array<Int>()
    var api_get_ship: ApiGetShip? = ApiGetShip()
    var api_get_eventflag: Int = 0
    var api_get_exmap_rate: Int = 0
    var api_get_exmap_useitem_id: Int = 0
    var api_escape_flag: Int = 0
    var api_escape: Any?

    required init() {

    }

}

class BattleResult: IBattleResult<BattleResultApiData> {

    override func process() {
        if let ship = api_data?.api_get_ship {
            Battle.instance.get = ship.api_ship_name
        }
        Battle.instance.phaseShift(value: Phase.BattleResult)

        setMissionProgress(bean: self, type: MissionRequireType.BATTLE)
    }

}

class BattleResultApiData: IBattleResultApiData {

}

class ApiGetShip: HandyJSON {

    var api_ship_id: Int = 0
    var api_ship_type: String = ""
    var api_ship_name: String = ""
    var api_ship_getmes: String = ""

    required init() {

    }

}

class ApiEnemyInfo: HandyJSON {

    var api_level: String = ""
    var api_rank: String = ""
    var api_deck_name: String = ""

    required init() {

    }

}