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
        
        
        cell.SelectionButtonalyout.layer.cornerRadius = 20
        cell.SelectionButtonalyout.clipsToBounds = true
        cell.SelectionButtonalyout.layer.shadowOffset = CGSize(width: 2, height: 2)
        cell.SelectionButtonalyout.layer.shadowColor = UIColor.black.cgColor
        cell.SelectionButtonalyout.layer.shadowOpacity = 0.23
        cell.SelectionButtonalyout.layer.shadowRadius = 4
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "shipping", sender: nil)
    }
    
    
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
