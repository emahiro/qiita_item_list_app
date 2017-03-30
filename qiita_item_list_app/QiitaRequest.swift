//
//  QiitaRequest.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol QiitaRequest {
    
    associatedtype Response: JSONDecodable
    
    var baseURL: URL { get }
    var resource: String { get }
    var method: String { get }
    var parameters: [String: Any] { get }
}

extension QiitaRequest {
    var baseURL: URL {
        return URL(string: "https://qiita.com/api/v2")!
    }
    
    var method: String {
        return "GET"
    }
    
    func buildURL() -> URLRequest {
        
        let url = baseURL.appendingPathComponent(resource)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = parameters.map { k, v in
            URLQueryItem(name: k, value: String(describing: v))
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        urlRequest.url = components?.url
        return urlRequest
    }
    
    func response(data: Data, urlResponse: URLResponse) throws -> Response {
        let json = JSON(data: data).object
        
        if case (200..<300)? = (urlResponse as? HTTPURLResponse)?.statusCode {
            return try Response(json: json)
        }
        else {
            throw try QiitaApiError.init(json: json)
        }
    }
    
    func alamofireResponse(data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        let json = JSON(data: data).object
        return try Response(json: json)
    }
}
