//
//  FilterListViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 1/6/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class FilterListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let picker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "wrgv"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? FilterListViewController {
            
        }
    }
    

}
