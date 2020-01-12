//
//  AuthenticationService.swift
//  floriaConsumer
//
//  Created by arabpas on 12/8/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD


class AuthenticationService {
    weak var delegate: WebServiceDelegate?
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    //user-tokens
    func postDeviceToken(_ token: String, deviceId: String) {
        let url = NetworkConstants.baseUrl + "user-tokens"
        let parameters = ["token": token,
                          "device_id": Defaults().getUniqueID(),
                          "device_type": "ios"] as [String : Any]
        
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                //let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                //self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        let url = NetworkConstants.baseUrl + "verify-code/\(mobile)"
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
    
    func changePass(mobile : String, pass : String, confirmPass : String) {
        let url = NetworkConstants.baseUrl + "reset-password/\(mobile)"
        let parameters = [
            "password" : pass,
            "password_confirmation" : confirmPass
        ] as [String : Any]
        
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
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
    
    
    
    func register(name : String , email: String, phone : String , password : String , checkPrivecy : Int) {
        let url = NetworkConstants.baseUrl + "register"
        let parameters = [
            "name" : name,
            "email" : email,
            "mobile" : phone,
            "password" : password,
            "check_privacy" : checkPrivecy,
            "device_id" : Defaults().getUniqueID()
        ] as [String : Any]
        HUD.show(.progress)
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                HUD.hide(animated: true)
                let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                HUD.flash(.labeledError(title: error.localizedDescription, subtitle: nil))
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
        HUD.show(.progress)
        Alamofire.request(url, method: .post, parameters: params, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                HUD.flash(.success)
                let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                HUD.flash(.labeledError(title: error.localizedDescription, subtitle: nil))
                print(error.localizedDescription)
            }
        }
    }
}
