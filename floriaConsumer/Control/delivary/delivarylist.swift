//
//  delivarylist.swift
//  floriaConsumer
//
//  Created by mac on 11/13/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class delivarylist: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! locationcell
        
//
//        cell.openProfileActionadd = {
//
//            cell.icone.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//
//
//        }
             return cell
    }
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell  = tableView.cellForRow(at: indexPath as IndexPath) as! locationcell
        cell.contentView.backgroundColor = .red
    }

    func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
         let cell  = tableView.cellForRow(at: indexPath as IndexPath) as! locationcell
        cell.contentView.backgroundColor = .clear
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! locationcell
//        cell.contentView.backgroundColor = .cyan
//        print(indexPath.row)
//        cell.icone.image = nil
//        tableView.reloadData()
//    }
    
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        shipping.layer.cornerRadius = 17
        // Do any additional setup after loading the view.
    }
    
  
    @IBOutlet weak var shipping: UIButton!
    @IBAction func back(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }

}
