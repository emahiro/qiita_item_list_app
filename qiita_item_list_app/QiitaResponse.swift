//
//  QiitaResponse.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation
import SwiftyJSON

struct QiitaResponse<T: JSONDecodable>: JSONDecodable {
    
    let items: [T]
    
    init(json: Any) throws {
        
        guard let itemObjs = JSON(json).arrayObject else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        self.items = try itemObjs.map {
            return try T.init(json: $0)
        }
    }
}
