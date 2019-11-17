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
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
             
             return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        shipping.layer.cornerRadius = 17
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var shipping: UIButton!
    
}
