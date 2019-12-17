//
//  resetpasswordAPI.swift
//  floriaConsumer
//
//  Created by mac on 12/17/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class resetpasswordAPI{
    
    
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    let vc = CustomAlert()
    var parameter : Parameters = [:]
    func sign( pass : String ,confirm : String, ext : String){
        let url = "http://api2.floriaapp.com/api/v1/"+ext
    
            
            parameter = ["password" : pass,
                         "password_confirmation" : confirm
            ]
        
       
        
        print(parameter,"909090900900009099090")
        Alamofire.request(url,method: .post, parameters: parameter, encoding: URLEncoding.default, headers: nil).responseData { re in
            switch re.result {
            case .failure(let erro):
                print("********////",erro.localizedDescription)
            case .success(let value):
                JSONResponseDecoder.decodeFrom(value, returningModelType: LoginModel.self) { (object, error) in
                    if error == nil {
                        print("🟢 \(object!)")
                        self.delegate?.didRecieveData(data: object)
                    }
                }
            }
        }
    }

}
