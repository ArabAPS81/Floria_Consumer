//
//  signup.swift
//  floriaConsumer
//
//  Created by mac on 14/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignupViewController: UIViewController {
    
    
    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var bu: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signup(_ sender: Any) {
        sign(name: name.text!, email: mobile.text!, password: pass.text!)
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
   let url = "http://api2.floriaapp.com/api/v1/register"
    func sign(name:String , email : String, password : String){
        
        let parameter : Parameters =
            [
                
                "name" : name,
                "mobile" : email,
                "check_privacy" : "1",
                "password": password
        ]
        
        print(parameter,"909090900900009099090")
        Alamofire.request(self.url,method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseJSON { re in
            switch re.result
            {
            case .failure(let erro):
                print("********////",erro)
            case .success(let value):
                var jsoncode = JSON(value)
                print(jsoncode,"00000000000000000")
                
                guard let data = jsoncode["data"].dictionary else  {self.alertt(header: "Alert ", body: "please check your data  ")
                    return }
                print(data,"???????????????")
                
                let token = jsoncode["data"]["access_token"].string
                UserDefaults.standard.set(token, forKey: "token")
                
                
            }
            
        }
        
        
    }

    func alertt(header:String,body:String ) {
        let alert = UIAlertController(title: header, message: body , preferredStyle: UIAlertController.Style.actionSheet)
        
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            // your code with delay
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
