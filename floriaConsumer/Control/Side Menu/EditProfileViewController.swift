//
//  EditProfileViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 3/16/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    
    static func newInstance() -> EditProfileViewController {
        let storyboard = UIStoryboard.init(name: "UserProfile", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "EditProfileViewController") as! EditProfileViewController
        return vc
    }
    
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userMailTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
    }
    
    func setData() {
        let user = Defaults().getUser()
        userMailTF.text = user.email
        userNameTF.text = user.name
    }
    
    @IBAction func addressesButtonTapped(_ sender: UIButton) {
        let vc = UserAddressListViewController.newInstance()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if validation() {
            let service = AuthenticationService.init(delegate: self)
            service.editProfile(name: userNameTF.text!, email: userMailTF.text!)
        }
    }
    
    func validation() -> Bool {
        guard let _ =  userNameTF.text ,!userNameTF.text!.isEmpty else {
            alertWithMessage(title: NSLocalizedString("not valid user name", comment: ""))
            return false
        }
        if !(userMailTF?.text ?? "").isValid(.email) {
            alertWithMessage(title: NSLocalizedString("not valid email", comment: ""))
            return false
        }
        return true
    }
    
}

extension EditProfileViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        if let model = data as? ComplainModel {
            if model.httpCode == 200 || model.httpCode == 201 {
                let phone = Defaults().getUser().phone
                Defaults().saveUserData(email: userMailTF.text, name: userNameTF.text, phone: phone)
                
            }
        }
    }
    
    
}
