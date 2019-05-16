//
// Created by CC on 2019-03-16.
// Copyright (c) 2019 CC. All rights reserved.
//

import Foundation
import RxSwift
import HandyJSON

class BattleCombinedResult: IBattleResult<BattleCombinedResultData> {

    override func process() {
        if let ship = api_data?.api_get_ship {
            Battle.instance.get = ship.api_ship_name
        }
        Battle.instance.phaseShift(value: Phase.BattleCombinedResult)

        setMissionProgress(bean: self, type: MissionRequireType.BATTLE)
    }

}

class BattleCombinedResultData: IBattleResultApiData {

    var api_mvp_combined: Int = 0
    var api_get_ship_exp_combined = Array<Int>()
    var api_get_exp_lvup_combined = Array<Array<Int>>()

}