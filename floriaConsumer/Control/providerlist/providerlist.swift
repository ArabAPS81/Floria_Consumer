//
//  providerlist.swift
//  floriaConsumer
//
//  Created by mac on 11/9/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class providerlist: UIViewController , UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "provider", for: indexPath) as! providerlistcellmodel
        cell.imgofprovider.layer.cornerRadius = 30
        cell.imgofprovider.clipsToBounds = true
        cell.view.layer.cornerRadius = 40
        cell.view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.view.layer.shadowOffset = .zero
     
        cell.view.layer.shadowOpacity = 1
       
        
        return cell
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(indexPath.row)
        self.performSegue(withIdentifier: "proudcts", sender: nil)
    }

    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
