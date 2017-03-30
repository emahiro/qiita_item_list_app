//
//  QiitaClientError.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation

enum QiitaClientError: Error {
    case connectionError(Error)
    case responseParseError(Error)
    case apiError(QiitaApiError)
}
