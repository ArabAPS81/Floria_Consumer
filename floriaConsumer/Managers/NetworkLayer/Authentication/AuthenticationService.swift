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
    func postDeviceToken(_ token: String) {
        let url = NetworkConstants.baseUrl + "provider/provider-tokens"
        let parameters = ["token": token,
                          "device_id": Defaults().getUniqueID(),
                          "device_type": "ios"] as [String : Any]
        
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
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
    
    func forgetPass(phone : String,countryCode: String) {
        let url = NetworkConstants.baseUrl + "forget-password"
        let parameters = ["mobile": phone,"country_code": countryCode]
        HUD.show(.progress)
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(ForgetPassModel.self, from: response.data!)
                if data.httpCode == 200 || data.httpCode == 201 {
                    HUD.flash(.success)
                }else{
                    HUD.flash(.error)
                }
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                HUD.flash(.error)
                print(error.localizedDescription)
            }
        }
    }
    
    func confirmUser(mobile : String, code : String) {
        let url = NetworkConstants.baseUrl + "verify-code/\(mobile)"
        let parameters = [
            "verification_code" : code
        ] as [String : Any]
        HUD.show(.progress)
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                if data.error == nil{
                    HUD.flash(.success)
                    
                }else{
                    HUD.flash(.error)
                }
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
                HUD.flash(.error)
                self.delegate?.didFailToReceiveDataWithError(error: error)
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
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    
    
    func register(name : String , email: String, phone : String , password : String , checkPrivecy : Int,countryCode: String,code:String, birthDate: String, gender: String) {
        let url = NetworkConstants.baseUrl + "register"
        let parameters = [
            "name" : name,
            "email" : email,
            "mobile" : phone,
            "password" : password,
            "country_code":countryCode,
            "code":code,
            "gender": gender,
            "birthday": birthDate,
            "check_privacy": checkPrivecy,
            "device_id": Defaults().getUniqueID(),
            
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
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func confirmNewUser(code : String) {
        let url = NetworkConstants.baseUrl + "verify"
        let parameters = [
            "verification_code" : code
        ] as [String : Any]
        HUD.show(.progress)
        let headers = WebServiceConfigure.getHeadersForAuthentication()
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                if data.error == nil{
                    HUD.flash(.success)
                }else{
                    HUD.flash(.error)
                }
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
                HUD.flash(.error)
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func logout() {
        let url = NetworkConstants.baseUrl + "logout"
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        Alamofire.request(url, method: .get, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                let data = try! JSONDecoder().decode(ResendModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.didFailToReceiveDataWithError(error: error)
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
                self.delegate?.didFailToReceiveDataWithError(error: error)
            }
        }
    }
    
    func loginWith(phoneNumber: String, password: String,countryCode:String) {
        let url = NetworkConstants.baseUrl + "login"
        
        let params: [String:String] = ["mobile": phoneNumber,
                                       "password":password,
                                       "country_code": countryCode]
        let headers = WebServiceConfigure.getHeadersForUnauthenticatedState()
        HUD.show(.progress)
        Alamofire.request(url, method: .post, parameters: params, headers: headers).responseJSON{ (response) in
            switch response.result {
            case .success(let value):
                print(value)
                HUD.hide(animated: true)
                let data = try! JSONDecoder().decode(AuthenticationModel.self, from: response.data!)
                self.delegate?.didRecieveData(data: data)
                break
                
            case .failure(let error):
                HUD.flash(.labeledError(title: error.localizedDescription, subtitle: nil))
                self.delegate?.didFailToReceiveDataWithError(error: error)
                print(error.localizedDescription)
            }
        }
    }
    
    func editProfile(name: String, email: String) {
        let url = NetworkConstants.baseUrl + "profile"
        let params: [String:String] = ["name": name,
                                       "email":email]
        let headers = WebServiceConfigure.getHeadersForAuthenticatedState()
        ApiConnection.request(.put, url: url, parameters: params, headers: headers, showProgress: true, model: ComplainModel.self, completion: { (result) in
            self.delegate?.didRecieveData(data: result)
        }) { (error) in
            self.delegate?.didFailToReceiveDataWithError(error: error)
        }
    }
    
}

