//
//  Tag.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Tag: JSONDecodable {
    let name: String
    let versions: [String]
    
    init(json: Any) throws {
        
        guard let dict = JSON(json).dictionaryObject else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let name = dict["name"] as? String else {
            throw JSONDecodeError.missingValue(id: "name", actualValue: dict["name"])
        }
        
        guard let versionArr = dict["versions"] as? [String] else {
            throw JSONDecodeError.missingValue(id: "versions", actualValue: dict["versions"])
        }
        
        self.name = name
        self.versions = versionArr.map { return $0 }
    }
}
