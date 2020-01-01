//
//  AuthenticationService.swift
//  floriaConsumer
//
//  Created by arabpas on 12/8/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
import Alamofire


class AuthenticationService {
    weak var delegate: WebServiceDelegate?
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    func forgetPass(phone : String) {
        let url = NetworkConstants.baseUrl + "forget-password"
        let parameters = ["mobile" : phone]
        
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(ForgetPassModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func confirmUser(mobile : String, code : String) {
        let url = NetworkConstants.baseUrl + "verify/\(mobile)"
        let parameters = [
            "verification_code" : code
        ] as [String : Any]
        
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func register(name : String , email: String, phone : String , password : String , checkPrivecy : Int) {
        let url = NetworkConstants.baseUrl + "register"
        let parameters = [
            "name" : name,
            "email" : email,
            "mobile" : phone,
            "password" : password,
            "check_privacy" : checkPrivecy
        ] as [String : Any]
        
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func confirmNewUser(code : String) {
        let url = NetworkConstants.baseUrl + "verify"
        let parameters = [
            "verification_code" : code
        ] as [String : Any]
        
        let headers = WebServiceConfigure.getHeadersForAuthentication()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func resend(mobile : String) {
        let url = NetworkConstants.baseUrl + "resend/\(mobile)"
        
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: [:], headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(ResendModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loginWith(phoneNumber: String, password: String) {
        let url = NetworkConstants.baseUrl + "login"
        
        let params: [String:String] = ["mobile": phoneNumber,
                                       "password":password]
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: params, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
