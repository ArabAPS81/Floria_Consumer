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
    @IBOutlet weak var nameTF: LimitedTextField!
    @IBOutlet weak var nameErrorLable: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailTF: LimitedTextField!
    @IBOutlet weak var emailErrorLable: UILabel!
    @IBOutlet weak var mobileContainer: UIView!
    @IBOutlet weak var mobileTF: LimitedTextField!
    @IBOutlet weak var birthDateTF: UITextField!
    @IBOutlet weak var mobileErrorLable: UILabel!
    @IBOutlet weak var passContainerView: UIView!
    @IBOutlet weak var passwordTF: LimitedTextField!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var confirmPassContainer: UIView!
    @IBOutlet weak var confirmPassTF: LimitedTextField!
    @IBOutlet weak var showConfirmPassBtn: UIButton!
    @IBOutlet weak var termsBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var countryFlagImage: UIImageView!
    @IBOutlet weak var countryCodeButton: UIButton!
    var phoneCode:String = "+2"
    var code: String = "EG"
    var selectedGender: UserGender = .male
    var birthDateString: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("Sign Up", comment: "")
        setUpViewsShapes()
        nameErrorLable.isHidden = true
        emailErrorLable.isHidden = true
        mobileErrorLable.isHidden = true
        birthDateTF.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthDateString = dateFormatter.string(from: Date())
        
        
        
       // nameTF.limitation = 7
        
    }
    
    @IBAction func showPassTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (passwordTF.isSecureTextEntry == true){
            passwordTF.isSecureTextEntry = false
        }else{
            passwordTF.isSecureTextEntry = true
        }
    }
    @IBAction func haveAccountTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let signInVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @IBAction func showConfrirmPassTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (confirmPassTF.isSecureTextEntry == true){
            confirmPassTF.isSecureTextEntry = false
            
        }else{
            
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
    var alert: UIAlertController!
    @IBAction func phoneCodeTapped(_ sender: UIButton) {
        alert = UIAlertController(style: .actionSheet, title: NSLocalizedString("Phone Codes", comment: ""))
        alert.addLocalePicker(type: .phoneCode) { info in
            self.countryFlagImage.image = info?.flag
            self.phoneCode = info?.phoneCode ?? "+2"
            self.code = info?.code ?? "EG"
            sender.setTitle(info?.phoneCode, for: .normal)
        }
        alert.addAction(title: NSLocalizedString("ok", comment: ""), style: .cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        if validation() {
            
            guard let name = nameTF.text?.trimmed , !name.isEmpty else {return}
            guard let email = emailTF.text?.trimmed , !email.isEmpty else {return}
            guard let mobile = mobileTF.text?.trimmed , !mobile.isEmpty else {return}
            guard let password = passwordTF.text , !password.isEmpty else {return}
            guard let confirmPass = confirmPassTF.text , !confirmPass.isEmpty else {return}
            guard password == confirmPass else {
                alertWithMessage("Passwords dont match")
                return
            }
            
            let service = AuthenticationService.init(delegate: self)
            service.register(name: name, email: email, phone: mobile, password: password, checkPrivecy: checkTerms, countryCode: phoneCode, code: code,birthDate: birthDateString, gender: selectedGender.rawValue)
        }
        
    }
    
    func validation() -> Bool {
        
        if !(emailTF.text?.trimmed.isValid(.email) ?? false) {
            alertWithMessage(title: "email is not valid")
            return false
        }
        if passwordTF.text?.count ?? 0 < 8  {
            alertWithMessage(title: "Password must be 8 or more charachters")
            return false
        }
        if !(mobileTF.text?.trimmed.isValid(.phone) ?? false) || phoneCode == nil {
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
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale.init(identifier: "en")
        var strDate = dateFormatter.string(from: datePicker.date)
        birthDateTF.text = strDate
        dateFormatter.dateFormat = "yyyy-MM-dd"
        birthDateString = dateFormatter.string(from: datePicker.date)
        
    }
    
    @IBOutlet var genderBtns: [UIButton]!
    @IBAction func genderSelected(_ sender: UIButton) {
        genderBtns.forEach{$0.isSelected = false}
           sender.isSelected = true
        selectedGender = (sender.tag == 1) ? UserGender.male : UserGender.female
       }
    
}

extension RegisterationViewController : WebServiceDelegate{
    func didRecieveData(data: Codable) {
        if let model = data as? AuthenticationModel {
            print(model)
            if model.httpCode == 201{
                Defaults.init().saveAuthenToken(authenToken : model.user?.accessToken ?? "")
                let vc = ConfirmationCodeViewController.newInstance(comingFromVC: "registration", mobile: model.user?.mobile ?? "")
                FloriaAppEvents.logCompleteRegistrationEvent()
                self.navigationController?.pushViewController(vc, animated: true)
            }else if model.httpCode == 422 {
                if let message = model.error?.message?.email?.first {
                    alertWithMessage(title: message)
                }else if let message = model.error?.message?.mobile?.first {
                    alertWithMessage(title: message)
                }else if let message = model.error?.message?.name?.first {
                    alertWithMessage(title: message)
                }else if let message = model.error?.message?.body?.first {
                    alertWithMessage(title: message)
                }
            }
        }
    }
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}
