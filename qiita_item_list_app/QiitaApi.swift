//
//  QiitaApi.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

final class QiitaApi {
    
    struct getItems: QiitaRequest {
        
        let per_page: Int
        let page: Int
        
        typealias Response = QiitaResponse<Item>
        
        var resource: String {
            return "/items"
        }
        
        var parameters: [String: Any] {
            return [
                "per_page": per_page,
                "page": page
            ]
        }
    }
    
    struct getItem: QiitaRequest {
        let id: String
        typealias Response = QiitaDetailResponse<Item>
        
        var resource: String {
            return "/items/\(id)"
        }
        
        var parameters: [String : Any] {
            return ["per_page": ""]
        }
    }
}
