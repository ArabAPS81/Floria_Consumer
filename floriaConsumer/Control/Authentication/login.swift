//
//  login.swift
//  floriaConsumer
//
//  Created by mac on 14/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class login: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sign.layer.cornerRadius = 20
        disshow.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    @IBAction func signin(_ sender: Any) {
        let vc = LoginService(delegate: self)
        vc.sign(name: "", email: name.text!, password: pass.text!, ext: "login")
    }
    
    
    @IBAction func skip(_ sender: Any) {
        self.performSegue(withIdentifier: "loged", sender: nil)
    }
    @IBOutlet weak var sign: UIButton!
    
    @IBOutlet weak var disshow: UIButton!
    @IBAction func sho(_ sender: Any) {
        if  pass.isSecureTextEntry == true
        {
            
            pass.isSecureTextEntry=false
            disshow.isHidden = false
        }
        else
        {
            disshow.isHidden = true
            pass.isSecureTextEntry=true
        }
    }
    
    @IBAction func forgetpass(_ sender: Any) {
        let vc = LoginService(delegate: self)
            vc.sign(name: "", email: name.text!, password: pass.text!, ext: "login")
    }
   
}
       
extension login: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}
    

