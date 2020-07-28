//
//  ConfirmationCodeViewController.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/29/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit
import PKHUD

class ConfirmationCodeViewController: UIViewController {
    
    var mobile : String!
    var comingFromVC : String!
    var event: ((UIViewController)->())!
    
    static func newInstance(comingFromVC : String ,mobile : String) -> ConfirmationCodeViewController {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let confirmCodeVC = storyboard.instantiateViewController(withIdentifier: "confirmCodeVC") as! ConfirmationCodeViewController
        confirmCodeVC.mobile = mobile
        confirmCodeVC.comingFromVC = comingFromVC
        return confirmCodeVC
    }
    
    @IBOutlet weak var timerLable: UILabel!
    @IBOutlet weak var resendBtn: UIButton!
    @IBOutlet weak var codeTF: UITextField!
    @IBOutlet weak var chagePassBtn: UIButton!
    
    var seconds = 60
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsShapes()
        self.title = NSLocalizedString("Verification Code", comment: "")
        resendBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        chagePassBtn.isEnabled = false
        chagePassBtn.backgroundColor = .darkGray
        codeTF.addTarget(self, action: #selector(textChanged(_:)), for: UIControl.Event.editingChanged)
        codeTF.delegate = self
    }
    
    @objc func textChanged(_ sender: UITextField) {
        if sender.text?.isValid(.verficationCode) ?? false {
            chagePassBtn.isEnabled = true
            chagePassBtn.backgroundColor = Constants.pincColor
        }else {
            chagePassBtn.isEnabled = false
            chagePassBtn.backgroundColor = .darkGray
        }
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        guard let code = codeTF.text?.trimmed , !code.isEmpty else {
            
            return}
        if comingFromVC == "registration"{
            let service = AuthenticationService.init(delegate: self)
            service.confirmNewUser(code: code)
        }
        else if comingFromVC == "forgetPass"{
            let service = AuthenticationService.init(delegate: self)
            service.confirmUser(mobile: mobile, code: code)
        }
        
    }
    
    @IBAction func resendTapped(_ sender: Any) {
        let service = AuthenticationService.init(delegate: self)
        service.resend(mobile: mobile)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        resendBtn.isHidden = true
        seconds = 60
    }
    
    func setUpViewsShapes(){
        
        resendBtn.layer.cornerRadius = 15
        resendBtn.clipsToBounds = true
        
        chagePassBtn.layer.cornerRadius = 30
        chagePassBtn.clipsToBounds = true
        
    }
    
    @objc func UpdateTimer(){
        if seconds != 0 {
            seconds -= 1
            timerLable.text = "00:\(seconds)"
        }else{
            timerLable.text = "00:00"
            resendBtn.isHidden = false
            print("\(seconds)")
        }
    }
}

extension ConfirmationCodeViewController : WebServiceDelegate{
    func didRecieveData(data: Codable) {
        if let data = data as? AuthenticationModel {
            if data.httpCode == 200 {
                if data.user?.verified ?? false {
                    Defaults.init().saveUserId(userId: data.user?.id ?? 0)
                    Defaults.init().saveUserToken(token : data.user?.accessToken ?? "")
                    Defaults().isUserLogged = true
                    Defaults().saveUserData(email: data.user?.email, name: data.user?.name, phone: data.user?.mobile)
                    if (event != nil) {
                        event(self)
                    } else {
                        self.performSegue(withIdentifier: "homeSegue", sender: nil)
                    }
                }
            }else if data.httpCode == 401{
                
            }
        }
    }
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}

extension ConfirmationCodeViewController:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}


