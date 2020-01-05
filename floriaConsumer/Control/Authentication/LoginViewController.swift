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

class LoginViewController: UIViewController {
    
    var event: ((UIViewController)->())!
    
    
    static func newInstance() -> LoginViewController {
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            
            return loginVC
    
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsShapes()
        self.title = "Login"
        failureLable.isHidden = true
        phoneTF.addTarget(self, action: #selector(handlePhoneChange), for: .editingDidEnd)
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var failureLable: UILabel!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func showPassTapped(_ sender: Any) {
        if (passTF.isSecureTextEntry == true){
            passTF.isSecureTextEntry = false
            showPassBtn.setImage(UIImage(named: "HidePass"), for: .normal)
        }else{
            showPassBtn.setImage(UIImage(named: "ShowPass"), for: .normal)
            passTF.isSecureTextEntry = true
        }
    }
    @IBAction func signin(_ sender: Any) {
        guard let Phone = phoneTF.text , !Phone.isEmpty else{return}
        guard let password = passTF.text , !password.isEmpty else{return}
        let service = AuthenticationService.init(delegate: self)
        service.loginWith(phoneNumber: Phone, password: password)
    }
    
    @IBAction func forgetpass(_ sender: Any) {
        
        
    }
    @IBAction func skipButtonTapped(_ sender: Any) {
        if (event != nil) {
            event(self)
        } else {
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
        }
    }
    
    func setUpViewsShapes() {
        loginBtn.layer.cornerRadius = 30
        loginBtn.clipsToBounds = true
    }
    @ objc func handlePhoneChange(){
        guard let text = phoneTF.text else{return}
        if text.isValid(.phone){
            print("Valid Text")
            failureLable.isHidden = true
        }else{
            failureLable.text = "Not a Valid Mobile"
            failureLable.isHidden = false
        }
    }
}
       
extension LoginViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let data = data as? AuthenticationModel {
            if data.httpCode == 200{
                Defaults.init().saveUserId(userId: data.user?.id ?? 0)
                Defaults.init().saveUserToken(token : data.user?.accessToken ?? "")
                Defaults().isUserLogged = true
                if (event != nil) {
                    event(self)
                } else {
                    self.performSegue(withIdentifier: "homeSegue", sender: nil)
                }
            }else if data.httpCode == 401{
                failureLable.text = "Your phone or password maybe wrong"
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}
    

