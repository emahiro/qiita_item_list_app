//
//  QiitaApiError.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation
import SwiftyJSON

struct QiitaApiError: Error, JSONDecodable {
    
    let message: String
    let type: String
    
    init(json: Any) throws {
        guard let dict = JSON(json).dictionaryObject else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let message = dict["message"] as? String else {
            throw JSONDecodeError.missingValue(id: "message", actualValue: dict["message"])
        }
        
        guard  let type = dict["type"] as? String else {
            throw JSONDecodeError.missingValue(id: "type", actualValue: dict["type"])
        }
        
        self.message = message
        self.type = type
    }
}
