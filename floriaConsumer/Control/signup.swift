//
//  signup.swift
//  floriaConsumer
//
//  Created by mac on 14/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit


class signup: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        bu.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
  
    

    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var bu: UIButton!
    
    @IBAction func signup(_ sender: Any) {
      
        
    }
   
    @IBOutlet weak var checkbox: UIButton!
    
    let full = UIImage(systemName: "rectangle.fill")
    let blanck = UIImage(systemName: "rectangle")
    @IBAction func terms(_ sender: Any) {
        checkbox.setImage(full, for: .normal)
    }
    
    @IBOutlet weak var disshow: UIButton!
    @IBAction func conditions(_ sender: Any) {
    }
    @IBAction func skip(_ sender: Any) {
        self.performSegue(withIdentifier: "done", sender: nil)
        
    }

    @IBAction func sho(_ sender: Any) {
              if  pass.isSecureTextEntry == true
              {
                 
                  pass.isSecureTextEntry=false
                disshow.isHidden = false
                
              }
              else
              {
                  
                  pass.isSecureTextEntry=true
                   disshow.isHidden = true
              }
          }
   
}
