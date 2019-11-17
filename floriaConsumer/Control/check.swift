//
//  check.swift
//  floriaConsumer
//
//  Created by mac on 21/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit

class check: UIViewController {
    override func viewDidLoad() {
         VIEW.layer.cornerRadius = 20
               okkkk.layer.cornerRadius = 10
    }
    @IBOutlet weak var phon: UITextField!
    @IBOutlet weak var okkkk: UIButton!
    
    @IBOutlet weak var VIEW: UIView!
    @IBAction func ok(_ sender: Any) {
       
    }
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
       
    }
   
    
   
    
}
