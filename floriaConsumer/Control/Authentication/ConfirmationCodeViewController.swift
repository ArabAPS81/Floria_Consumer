//
//  ConfirmationCodeViewController.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/29/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class ConfirmationCodeViewController: UIViewController {
    
    var mobile : String!
    var comingFromVC : String!
    
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
        resendBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        guard let code = codeTF.text?.trimmed , !code.isEmpty else {return}
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
        if let model = data as? AuthenticationModel {
            if model.httpCode == 200{
                if comingFromVC == "registration"{
                    let vc = HomeNav.newInstance()
                    self.present(vc, animated: true)
                }
                else if comingFromVC == "forgetPass"{
                    let vc = NewPassViewController.newInstance(mobile: mobile)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
        }
    }
    
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
}
