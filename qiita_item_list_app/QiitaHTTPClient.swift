//
//  QiitaHTTPClient.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class QiitaHTTPClient {
    
    private var session: URLSession {
        return URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func send<Request: QiitaRequest>(request: Request, completion: @escaping (Result<Request.Response, QiitaClientError>)->Void) {
        
        let task: URLSessionTask = session.dataTask(with: request.buildURL()) { data, response, error in
            
            switch (data, response, error) {
            case (_, _, let error?):
                completion(Result(error: QiitaClientError.connectionError(error)))
            case (let data?, let response?, _):
                do {
                    let response = try request.response(data: data, urlResponse: response)
                    completion(Result(value: response))
                } catch let e as QiitaApiError {
                    completion(Result(error: QiitaClientError.apiError(e)))
                } catch let e {
                    completion(Result(error: QiitaClientError.responseParseError(e)))
                }
                
            default:
                fatalError("invalid Json Response Conbination data: \(data) response: \(response) error: \(error)")
            }
        }
        
        task.resume()
    }
    
    
    // Alamofire using
    func get<Request: QiitaRequest>(request: Request, completion: @escaping (Result<Any, QiitaClientError>) -> Void) {
        
        Alamofire.request(request.buildURL())
            .validate(statusCode: (200..<300))
            .response { response in
                if response.error != nil {
                    let e = response.error as! QiitaApiError
                    completion(Result(error: QiitaClientError.apiError(e)))
                }
                
                completion(Result(value: JSON(data: response.data!).object ))
                
                // 呼び出す側(クライアントサイド)
                // using Alamofire
                //        client.get(request: request) { result in
                //            switch result {
                //            case let Result.success(json):
                //                print("Response Success: \(json)")
                //            case let Result.failure(error):
                //                print(error)
                //            }
                //        }
        }
    }
}
