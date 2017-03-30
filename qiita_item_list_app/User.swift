//
//  User.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User: JSONDecodable {
    
    let id: String
    let name: String
    let profileImageUrl: URL
    
    init(json: Any) throws {
        
        guard let dict = JSON(json).dictionaryObject else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let id = dict["id"] as? String else {
            throw JSONDecodeError.missingValue(id: "id", actualValue: dict["id"])
        }
        
        guard let name = dict["name"] as? String else {
            throw JSONDecodeError.missingValue(id: "name", actualValue: dict["name"])
        }
        
        guard let profileImageUrlStr = dict["profile_image_url"] as? String else {
            throw JSONDecodeError.missingValue(id: "profile_image_url", actualValue: dict["profile_image_url"])
        }
        
        self.id = id
        self.name = name
        self.profileImageUrl = URL(string: profileImageUrlStr)!
    }
}
