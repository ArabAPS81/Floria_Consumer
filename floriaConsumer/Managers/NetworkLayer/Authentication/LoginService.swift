//
//  LoginService.swift
//  floriaConsumer
//
//  Created by mac on 12/11/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginService: NSObject {
    let url = "http://api2.floriaapp.com/api/v1/login"
    let vc = CustomAlert()
    func sign( name : String ,email : String, password : String , ext : String){
             let url = "http://api2.floriaapp.com/api/v1/"+ext
                 
        
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
                 
                         guard let data = jsoncode["data"].dictionary else  {
                            if ext == "login"{
                            self.vc.alertt(header: "Alert ", body: "please check your data  ", view: login())
                            }
                            else{
                                UserDefaults.standard.set("1", forKey: "register")
                            }
                            return }
                         print(data,"???????????????")
                       
                         let token = data["access_token"]?.string
                             UserDefaults.standard.set(token, forKey: "tocken")
                          
                             
                         }
                         
                     }
                     
                     
                 }
         
}
