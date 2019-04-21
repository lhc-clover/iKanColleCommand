//
// Created by CC on 2019-03-31.
// Copyright (c) 2019 CC. All rights reserved.
//

import Foundation

enum MissionRequireType {
    case NONE,
         BATTLE, //出击
         EXPEDITION, //远征
         REPAIR, //入渠
         SUPPLY, //补给
         PRACTICE, //演习
         CREATE_ITEM, //开发
         CREATE_SHIP, //建造
         DESTROY_ITEM, //废弃
         DESTROY_SHIP, //解体
         REMODEL_SLOT, //改修
         POWER_UP //强化
}