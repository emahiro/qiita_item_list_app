//
//  JSONDecodable.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    init (json: Any) throws
}
