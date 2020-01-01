//
//  RegistrationViewController.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/28/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class RegisterationViewController: UIViewController {
    
    var checkTerms : Int!
    
    @IBOutlet weak var nameContainerView: UIView!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var nameErrorLable: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var emailErrorLable: UILabel!
    @IBOutlet weak var mobileContainer: UIView!
    @IBOutlet weak var mobileTF: UITextField!
    @IBOutlet weak var mobileErrorLable: UILabel!
    @IBOutlet weak var passContainerView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var confirmPassContainer: UIView!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var showConfirmPassBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    @IBAction func showPassTapped(_ sender: Any) {
        if (passwordTF.isSecureTextEntry == true){
            passwordTF.isSecureTextEntry = false
            showPassBtn.setImage(UIImage(named: "HidePass"), for: .normal)
        }else{
            showPassBtn.setImage(UIImage(named: "ShowPass"), for: .normal)
            passwordTF.isSecureTextEntry = true
        }
    }
    @IBAction func haveAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.navigationController?.pushViewController(signInVC, animated: true)
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
    
    @IBAction func termsTappped(_ sender: Any) {
        if(termsBtn.isSelected){
            termsBtn.isSelected = false
            checkTerms = nil
        }else{
            termsBtn.isSelected = true
            checkTerms = 1
        }
    }
    
    @IBAction func termsViewTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let termsVC = storyboard.instantiateViewController(withIdentifier: "termsVC") as! TermsViewController
        self.navigationController?.pushViewController(termsVC, animated: true)
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        guard let name = nameTF.text?.trimmed , !name.isEmpty else {return}
        guard let email = emailTF.text?.trimmed , !email.isEmpty else {return}
        guard let mobile = mobileTF.text?.trimmed , !mobile.isEmpty else {return}
        guard let password = passwordTF.text?.trimmed , !password.isEmpty else {return}
        guard let confirmPass = confirmPassTF.text?.trimmed , !confirmPass.isEmpty else {return}
        guard password == confirmPass else{return}
        
        let service = AuthenticationService.init(delegate: self)
        service.register(name: name, email: email, phone: mobile, password: password, checkPrivecy: checkTerms)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registration"
        setUpViewsShapes()
        nameErrorLable.isHidden = true
        emailErrorLable.isHidden = true
        mobileErrorLable.isHidden = true
        
        nameTF.addTarget(self, action: #selector(handleNameChange), for: .editingDidEnd)
        emailTF.addTarget(self, action: #selector(handleEmailChange), for: .editingDidEnd)
        mobileTF.addTarget(self, action: #selector(handleMobileChange), for: .editingDidEnd)
    }
    func setUpViewsShapes(){
        termsBtn.layer.cornerRadius = 5
        termsBtn.clipsToBounds = true
        termsBtn.layer.borderWidth = 1
        termsBtn.layer.borderColor = AppColors.pink
        
        registerBtn.layer.cornerRadius = 30
        registerBtn.clipsToBounds = true
    }
    
    @ objc func handleEmailChange(){
        guard let text = emailTF.text else{return}
        if text.isValid(.email){
            print("Valid Text")
            emailErrorLable.isHidden = true
        }else{
            emailErrorLable.text = "Not A Valid Email"
            emailErrorLable.isHidden = false
        }
    }
    
    @ objc func handleNameChange(){
        guard let text = nameTF.text else{return}
        if text.isValid(.name){
            nameErrorLable.isHidden = true
        }else{
            nameErrorLable.text = "Not A Valid Name"
            nameErrorLable.isHidden = false
        }
    }
    
    @ objc func handleMobileChange(){
        guard let text = mobileTF.text else{return}
        if text.isValid(.phone){
            print("Valid Text")
            mobileErrorLable.isHidden = true
        }else{
            mobileErrorLable.text = "Not A Valid Mobile"
            mobileErrorLable.isHidden = false
        }
    }
}

extension RegisterationViewController : WebServiceDelegate{
    func didRecieveData(data: Codable) {
        if let model = data as? AuthenticationModel {
            print(model)
            if model.httpCode == 201{
                Defults.init().saveAuthenToken(authenToken : model.user?.accessToken ?? "")
                let vc = ConfirmationCodeViewController.newInstance(comingFromVC: "registration", mobile: model.user?.mobile ?? "")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}
