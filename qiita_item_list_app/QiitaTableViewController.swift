//
//  QiitaTableViewController.swift
//  qiita_item_list_app
//
//  Created by Hiromichi Ema on 2017/03/27.
//  Copyright © 2017年 Hiromichi Ema. All rights reserved.
//

import UIKit
import SVProgressHUD

class QiitaTableViewController: UITableViewController {
    
    // MARK: Properties
    var items = [Item]()
    let client = QiitaHTTPClient()
    let ITEM_NUM = 10
    var pageNum = 1
    
    private func loadItems(_ itemNum: Int, _ pageNum: Int) {
        
        let request = QiitaApi.getItems(per_page: itemNum, page: pageNum)
        SVProgressHUD.show()
        
        self.client.send(request: request) { result in
            switch result {
            case let Result.success(response):
                self.items += response.items
                self.tableView.reloadData()
                
                // 次の読み込みようにpageNum更新
                self.pageNum += 1
                
                SVProgressHUD.dismiss()
            case let Result.failure(error):
                print(error)
            }
        }
    }
    
    private func loadImage(imageUrl:URL) -> UIImage? {
        // loadImage
        do {
            let imageData = try NSData(contentsOf: imageUrl, options: .dataReadingMapped)
            return UIImage(data: imageData as Data)
        } catch let e {
            print("ImageLoadError: \(e)")
        }
        
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // itemの読み込み
        loadItems(self.ITEM_NUM, self.pageNum)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "QiitaTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QiitaTableViewCell else {
            fatalError("The dequeued cell is not an instance of QiitaTableViewCells")
        }
        
        if self.items.count > 0 {
            let item = self.items[indexPath.row]
            cell.itemTitle.text = item.title
            cell.userName.text = item.user.id
            cell.itemId.text = item.id
            cell.userProfileImage.image = loadImage(imageUrl: item.user.profileImageUrl)
        }
        
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier ?? "" {
        case "ShowItem":
            
            guard let qiitaItemViewController = segue.destination as? QiitaItemViewController else {
                fatalError("Unexpected segue destination: \(segue.destination)")
            }
            
            guard let selectedCell = sender as? QiitaTableViewCell else {
                fatalError("Unexpected sender : \(String(describing: sender))")
            }
            
            guard let itemId = selectedCell.itemId.text else {
                fatalError("Unexpected itemId: \(String(describing: selectedCell.itemId.text))")
            }
            
            qiitaItemViewController.itemId = itemId
            
        default:
            fatalError("Unexpected segue identifier: \(String(describing: segue.identifier))")
        }
    }
    
    // MARK: - ScrollView
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
