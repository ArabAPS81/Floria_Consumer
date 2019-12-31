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
        face.layer.cornerRadius = 20
    }
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var pass: UITextField!
    @IBAction func signin(_ sender: Any) {
        let service = AuthenticationService.init(delegate: self)
        let ph = name.text ?? ""
        let pas = pass.text ?? ""
        
        
        service.loginWith(phoneNumber: ph, password: pas)
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
        
    }
   
    @IBOutlet weak var face: UIButton!
}
       
extension login: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? AuthenticationModel {
            print(model)
            if model.httpCode == 200{
                Defults.init().saveUserToken(token : model.user?.accessToken ?? "")
                performSegue(withIdentifier: "loged", sender: nil)
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}
    

