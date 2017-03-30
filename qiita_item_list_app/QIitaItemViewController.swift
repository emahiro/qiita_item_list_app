//
//  ViewController.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/24.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import UIKit

class QiitaItemViewController: UIViewController {
    
    var urlRequest: URLRequest?
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let urlRequest = self.urlRequest else {
            fatalError("Invalid URL Error")
        }
        
        print(urlRequest.url)
        webView.loadRequest(urlRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

