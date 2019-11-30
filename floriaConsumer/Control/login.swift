//
//  login.swift
//  floriaConsumer
//
//  Created by mac on 14/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit

class login: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        sign.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var name: UITextField!
  
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var Done: UIScrollView!
    @IBAction func signin(_ sender: Any) {
    }
    
    
    @IBAction func skip(_ sender: Any) {
        self.performSegue(withIdentifier: "loged", sender: nil)
    }
    @IBOutlet weak var sign: UIButton!
    @IBAction func sho(_ sender: Any) {
           if  pass.isSecureTextEntry == true
           {
              
               pass.isSecureTextEntry=false
            
           }
           else
           {
               
               pass.isSecureTextEntry=true
               
           }
       }
    
 
    
   
    }

