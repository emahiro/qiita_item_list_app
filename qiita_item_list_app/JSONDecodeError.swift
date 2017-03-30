//
//  JSONDecodeError.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

enum JSONDecodeError: Error {
    case invalidFormat(json: Any)
    case missingValue(id: String, actualValue: Any?)
}
