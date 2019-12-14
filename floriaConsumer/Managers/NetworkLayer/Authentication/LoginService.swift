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



class LoginService {
    
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    let vc = CustomAlert()
    var parameter : Parameters = [:]
    func sign( name : String ,email : String, password : String , ext : String){
        let url = "http://api2.floriaapp.com/api/v1/"+ext
        if ext == "verify"{
            parameter = ["verification_code" : name ]
        }else if ext == "forget-password" {
            
            parameter = ["mobile" : name ]
            
        }else{
            
            parameter = ["name" : name,
                         "mobile" : email,
                         "check_privacy" : "1",
                         "password": password
            ]
        }
        let header =   [
            "Authorization": "Bearer " + "BQB8rIWF7Lk267E7o7pKNPhFvK4F6WoY16nKddTj4BdGLw5IF5hQM8Xk2ZlJFH0xJM7MR8fgqIdfSFmGMe9VVvmSWEg3mb1XGGvvntwV0VFyJBEQfmgH0XQ32VVIcFt__0xeTqzxs0J"
        ]
        
        print(parameter,"909090900900009099090")
        Alamofire.request(url,method: .post, parameters: parameter, encoding: URLEncoding.default, headers: header).responseData { re in
            switch re.result {
            case .failure(let erro):
                print("********////",erro.localizedDescription)
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: LoginModel.self) { (object, error) in
                    if error == nil {
                        self.delegate?.didRecieveData(data: object)
                    }
                }
            }
        }
    }
}


struct LoginModel: Codable {
    
    let data : Data?
    let httpCode : Int?
    let message : String?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case httpCode = "http_code"
        case message = "message"
    }
    
    struct User : Codable {
        
        let accessToken : String?
        let createdAt : String?
        let email : String?
        let expiresAt : String?
        let id : Int?
        let mobile : String?
        let name : String?
        let tokenType : String?
        let verified : Bool?
        
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token"
            case createdAt = "created_at"
            case email = "email"
            case expiresAt = "expires_at"
            case id = "id"
            case mobile = "mobile"
            case name = "name"
            case tokenType = "token_type"
            case verified = "verified"
        }
    }
}
