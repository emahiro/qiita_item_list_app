//
//  ViewController.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/24.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import UIKit
import SVProgressHUD

class QiitaItemViewController: UIViewController {
    
    var itemId = String()
    let client = QiitaHTTPClient()
    
    // MARK: IBOutlet
    @IBOutlet weak var webView: UIWebView!
    
    private func loadItem(){
        let request = QiitaApi.getItem(id: self.itemId)
        SVProgressHUD.show()
        self.client.send(request: request){ result in
            switch result {
            case let Result.success(response):
                let html = response.item.renderedBody
                self.webView.loadHTMLString(html, baseURL: nil)
                SVProgressHUD.dismiss()
            case let Result.failure(error):
                print(error)
                SVProgressHUD.dismiss()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

