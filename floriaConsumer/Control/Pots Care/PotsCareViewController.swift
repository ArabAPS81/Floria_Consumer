//
//  PotsCareViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/9/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class PotsCareViewController: UIViewController {
    
    static func newInstance() -> PotsCareViewController {
        let storyboard = UIStoryboard.init(name: "PotsCare", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "PotsCareViewController") as! PotsCareViewController
        return vc
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseLocationButtonTapped(_ sender: UIButton) {
        let vc = AddressesListViewController.newInstance(serviceType: .potsCare)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
