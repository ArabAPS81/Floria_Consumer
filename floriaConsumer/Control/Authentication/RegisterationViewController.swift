//
//  RegistrationViewController.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/28/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

enum UserGender:String {
    case male,female
}

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
    @IBOutlet weak var birthDateTF: UITextField!
    @IBOutlet weak var mobileErrorLable: UILabel!
    @IBOutlet weak var passContainerView: UIView!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var confirmPassContainer: UIView!
    @IBOutlet weak var confirmPassTF: UITextField!
    @IBOutlet weak var showConfirmPassBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var countryCodeButton: UIButton!
    var phoneCode:String = "+2"
    var code: String = "EG"
    var selectedGender: UserGender = .male
    
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
    
    @IBAction func phoneCodeTapped(_ sender: UIButton) {
        let alert = UIAlertController(style: .actionSheet, title: "Phone Codes")
        alert.addLocalePicker(type: .phoneCode) { info in
            self.countryFlagImage.image = info?.flag
            sender.setTitle(info?.phoneCode, for: .normal)
        }
        alert.addAction(title: NSLocalizedString("ok", comment: ""), style: .cancel)
        alert.show()
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        if validation() {
            
            guard let name = nameTF.text?.trimmed , !name.isEmpty else {return}
            guard let email = emailTF.text?.trimmed , !email.isEmpty else {return}
            guard let mobile = mobileTF.text?.trimmed , !mobile.isEmpty else {return}
            guard let password = passwordTF.text?.trimmed , !password.isEmpty else {return}
            guard let confirmPass = confirmPassTF.text?.trimmed , !confirmPass.isEmpty else {return}
            guard password == confirmPass else {
                alertWithMessage("Passwords dont match")
                return
            }
            
            let service = AuthenticationService.init(delegate: self)
            service.register(name: name, email: email, phone: mobile, password: password, checkPrivecy: checkTerms, countryCode: phoneCode, code: code,birthDate: birthDateTF.text ?? "", gender: selectedGender.rawValue)
        }
        
    }
    
    func validation() -> Bool {
        if !(nameTF.text?.isValid(.name) ?? false) {
            alertWithMessage(title: "Name is not valid")
            return false
        }
        if !(emailTF.text?.isValid(.email) ?? false) {
            alertWithMessage(title: "email is not valid")
            return false
        }
        if passwordTF.text?.count ?? 0 < 8  {
            alertWithMessage(title: "Password must be 8 or more charachters")
            return false
        }
        if !(mobileTF.text?.isValid(.phone) ?? false) || phoneCode == nil {
            alertWithMessage(title: "Phone number is not valid")
            return false
        }
        if checkTerms == nil {
            alertWithMessage(title: "You have to agree to terms and conditions")
            return false
        }
        if !(passwordTF.text?.elementsEqual(confirmPassTF.text ?? "") ?? false) {
            alertWithMessage(title: "Passwords dont match")
            return false
        }
        return true
    }
    
    let datePicker = UIDatePicker.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Registration"
        setUpViewsShapes()
        nameErrorLable.isHidden = true
        emailErrorLable.isHidden = true
        mobileErrorLable.isHidden = true
        birthDateTF.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
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
    
    @objc func dateChanged(_ sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale.init(identifier: "en")
        let strDate = dateFormatter.string(from: datePicker.date)
        birthDateTF.text = strDate
    }
    
    @IBOutlet var genderBtns: [UIButton]!
    @IBAction func genderSelected(_ sender: UIButton) {
        genderBtns.forEach{$0.isSelected = false}
           sender.isSelected = true
        selectedGender = (sender.tag == 1) ? UserGender.male : UserGender.female
       }
    
    @ objc func handleEmailChange(){
        guard let text = emailTF.text, !text.isEmpty else{ emailErrorLable.isHidden = false
            emailErrorLable.text = "This field is required"
            return}
        if text.isValid(.email){
            print("Valid Text")
            emailErrorLable.isHidden = true
        }else if !text.isEmpty{
            emailErrorLable.text = "Not A Valid Email"
            emailErrorLable.isHidden = false
        }
    }
    
    @ objc func handleNameChange(){
        guard let text = nameTF.text , !text.isEmpty else{  nameErrorLable.isHidden = false
            nameErrorLable.text = "This field is required"
            return}
        if text.isValid(.name){
            nameErrorLable.isHidden = true
        }else if !text.isEmpty{
            nameErrorLable.text = "Not A Valid Name"
            nameErrorLable.isHidden = false
        }
    }
    
    @ objc func handleMobileChange(){
        guard let text = mobileTF.text else{mobileErrorLable.isHidden = false
            mobileErrorLable.text = "This field is required"
            return}
        if text.isValid(.phone){
            print("Valid Text")
            mobileErrorLable.isHidden = true
        }else if !text.isEmpty{
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
                Defaults.init().saveAuthenToken(authenToken : model.user?.accessToken ?? "")
                let vc = ConfirmationCodeViewController.newInstance(comingFromVC: "registration", mobile: model.user?.mobile ?? "")
                self.navigationController?.pushViewController(vc, animated: true)
            }else if model.httpCode == 422 {
                if let message = model.error?.message?.email?.first {
                    alertWithMessage(title: message)
                }else if let message = model.error?.message?.mobile?.first {
                    alertWithMessage(title: message)
                }
            }
        }
    }
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}
