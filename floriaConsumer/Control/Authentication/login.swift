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
                let token = data["access_token"]?.string
                UserDefaults.standard.set(token, forKey: "tocken")
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
       
   
    

