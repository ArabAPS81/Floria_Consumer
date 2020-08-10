//
//  resetpasswordVC.swift
//  floriaConsumer
//
//  Created by mac on 12/14/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class NewPassViewController: UIViewController {
    
    var mobile : String!
    var user: AuthenticationModel!
    static func newInstance(mobile : String) -> NewPassViewController {
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let newPassVC = storyboard.instantiateViewController(withIdentifier: "newPassVC") as! NewPassViewController
        newPassVC.mobile = mobile
            
            return newPassVC
    
        }
    
    
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var showConfirmPassBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    
    @IBAction func showPassTapped(_ sender: Any) {
        if (passwordTF.isSecureTextEntry == true){
            passwordTF.isSecureTextEntry = false
            showPassBtn.setImage(UIImage(named: "ShowPass"), for: .normal)
        }else{
            showPassBtn.setImage(UIImage(named: "HidePass"), for: .normal)
            passwordTF.isSecureTextEntry = true
        }
    }
    
    @IBAction func showConfrirmPassTapped(_ sender: Any) {
        if (confirmPassTF.isSecureTextEntry == true){
            confirmPassTF.isSecureTextEntry = false
            showConfirmPassBtn.setImage(UIImage(named: "HidePass"), for: .normal)
        }else{
            showConfirmPassBtn.setImage(UIImage(named: "ShowPass"), for: .normal)
            confirmPassTF.isSecureTextEntry = true
        }
        
    }
 
    @IBAction func saveTapped(_ sender: Any) {
        guard let password = passwordTF.text , !password.isEmpty else{return}
        guard let confirmPassword = confirmPassTF.text , !confirmPassword.isEmpty else{return}
        
        guard password == confirmPassword else {
            alertWithMessage("Passwords dont match")
            return
        }
        
        let service = AuthenticationService.init(delegate: self)
        service.changePass(mobile: mobile, pass: password, confirmPass: confirmPassword)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Reset Password", comment: "")
    }
    
}

extension NewPassViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? ResendModel{
            if model.httpCode == 200{
                Defaults.init().saveUserId(userId: user.user?.id ?? 0)
                Defaults.init().saveUserToken(token : user.user?.accessToken ?? "")
                Defaults().saveUserData(email: user.user?.email, name: user.user?.name, phone: user.user?.mobile)
                Defaults().isUserLogged = true
                self.performSegue(withIdentifier: "homeSegue", sender: nil)
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}
