//
//  Item.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Item: JSONDecodable {
    
    let renderedBody: String
    let body: String
    let createdAt: String
    let id: String
    let tags: [Tag]
    let title: String
    let url: URL
    let user: User
    
    init(json: Any) throws {

        guard let dict = JSON(json).dictionaryObject else {
            throw JSONDecodeError.invalidFormat(json: json)
        }
        
        guard let renderedBody = dict["rendered_body"] as? String else {
            throw JSONDecodeError.missingValue(id: "rendered_body", actualValue: dict["rendered_boduy"])
        }
        
        guard let body = dict["body"] as? String else {
            throw JSONDecodeError.missingValue(id: "body", actualValue: dict["body"])
        }
        
        guard let createdAt = dict["created_at"] as? String else {
            throw JSONDecodeError.missingValue(id: "created_at", actualValue: dict["created_at"])
        }
        
        guard let id = dict["id"] as? String else {
            throw JSONDecodeError.missingValue(id: "id", actualValue: dict["id"])
        }
        
        guard let tagObj = dict["tags"] as? [Any] else {
            throw JSONDecodeError.missingValue(id: "tags", actualValue: dict["tags"])
        }
        
        guard let title = dict["title"] as? String else {
            throw JSONDecodeError.missingValue(id: "title", actualValue: dict["title"])
        }
        
        guard let urlStr = dict["url"] as? String else {
            throw JSONDecodeError.missingValue(id: "url", actualValue: dict["url"])
        }
        
        guard let userObj = dict["user"] else {
            throw JSONDecodeError.missingValue(id: "user", actualValue: dict["user"])
        }
        
        self.renderedBody = renderedBody
        self.body = body
        self.createdAt = createdAt
        self.id = id
        self.tags = try tagObj.map {
            return try Tag.init(json: $0)
        }
        self.title = title
        self.url = URL(string: urlStr)!
        self.user = try User.init(json: userObj)
    }
}

