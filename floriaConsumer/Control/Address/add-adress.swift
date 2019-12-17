//
//  add-adress.swift
//  floriaConsumer
//
//  Created by mac on 11/14/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class add_adress: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
  
    
    
    @IBAction func ADD(_ sender: Any) {
        let vc = popupVC()
        vc.customalert(header: "Done", body: "Your address is added")
        self.dismiss(animated: true, completion: nil)

    }


}
