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
import FirebaseMessaging
import AuthenticationServices

class LoginViewController: UIViewController {
    
    var event: ((UIViewController)->())!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var passTF: UITextField!
    @IBOutlet weak var failureLable: UILabel!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var countryFlagImage: UIImageView!
    var appleClient: Any?
    var phoneCode = "+2"
    
    static func newInstance() -> LoginViewController {
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC") as! LoginViewController
            return loginVC
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneTF.keyboardType = .asciiCapableNumberPad
        setUpViewsShapes()
        self.title = NSLocalizedString("Sign In", comment: "")
       // failureLable.isHidden = true
        phoneTF.addTarget(self, action: #selector(handlePhoneChange), for: .editingDidEnd)
        hideKeyboardWhenTappedAround()
        countryFlagImage.image = UIImage.init(named: "Egypt.png")
    
        
        Messaging.messaging().subscribe(toTopic: "general") { error in
          print("Subscribed to general topic")
        }
        Messaging.messaging().subscribe(toTopic: "consumer") { error in
          print("Subscribed to consumer topic")
        }
        
        if #available(iOS 13.0, *) {
            setupProviderLoginView()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        passTF.text = ""
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        countryFlagImage.image = UIImage.init(named: "Egypt.png")
    }
    
    @available(iOS 13.0, *)
    func setupProviderLoginView() {
        
        
      
    }
    
    @IBAction private func takeSigningActionOnTap(_ sender: UIButton) {
        
        if #available(iOS 13.0, *) {
            appleClient = AppleClient.init()
            (appleClient as! AppleClient).SignInWithApple()
        }
    }
    
    
    @IBAction func showPassTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if (passTF.isSecureTextEntry == true){
            passTF.isSecureTextEntry = false
        }else{
            passTF.isSecureTextEntry = true
        }
    }
    @IBAction func signin(_ sender: Any) {
        
        if validation() {
            let Phone = phoneTF.text!
            let password = passTF.text!
            let service = AuthenticationService.init(delegate: self)
            service.loginWith(phoneNumber: Phone, password: password, countryCode: phoneCode)
        }
    }
    
    func validation() -> Bool {
        if !(phoneTF.text ?? "").isValid(.phone) {
            alertWithMessage(title: NSLocalizedString("Enter avalid mobile number", comment: ""))
            return false
        }
        if passTF.text?.count ?? 0 < 8 {
            alertWithMessage(title: NSLocalizedString("Enter avalid password", comment: ""))
            return false
        }
        return true
    }
    
    @IBAction func phoneCodeTapped(_ sender: UIButton) {
        let alert = UIAlertController(style: .actionSheet, title: NSLocalizedString("Phone Codes", comment: ""))
        alert.addLocalePicker(type: .phoneCode) { info in
            self.countryFlagImage.image = info?.flag
            self.phoneCode = info?.phoneCode ?? "+2"
            sender.setTitle(info?.phoneCode, for: .normal)
        }
        alert.addAction(title: NSLocalizedString("ok", comment: ""), style: .cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func appleSignIn(_ sender: Any) {
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
            failureLable.text = ""
        }else{
            failureLable.text = NSLocalizedString("Enter avalid mobile number", comment: "")
           // failureLable.isHidden = false
        }
    }
}
       
extension LoginViewController: WebServiceDelegate {
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
                }else{
                    Defaults.init().saveUserId(userId: data.user?.id ?? 0)
                    Defaults.init().saveUserToken(token : data.user?.accessToken ?? "")
                    Defaults().isUserLogged = false
                    Defaults().saveUserData(email: data.user?.email, name: data.user?.name, phone: data.user?.mobile)
                    let vc = ConfirmationCodeViewController.newInstance(comingFromVC: "registration", mobile: data.user!.mobile!)
                    vc.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }else if data.httpCode == 401{
                
            }
        }
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}

@available(iOS 13.0, *)
class AppleClient:NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    weak var window: UIWindow?
    
    
    
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return window ?? UIApplication.shared.keyWindow!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            if fullName != nil {
                
                
            }
        case _ as ASPasswordCredential:
        
            // Sign in using an existing iCloud Keychain credential.
//            let username = passwordCredential.user
//            let password = passwordCredential.password
            break
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    
    func SignInWithApple() {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
    }
}


