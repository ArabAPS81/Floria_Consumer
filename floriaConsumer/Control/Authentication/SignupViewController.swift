//
//  SignupViewController.swift
//  floriaConsumer
//
//  Created by mac on 14/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit


class SignupViewController: UIViewController {

    override func viewDidLoad() {
        if UserDefaults.standard.string(forKey: "register") == "1"{
            self.alertt(header: "Alert ", body: "please check your data  ")
        }
        super.viewDidLoad()
        bu.layer.cornerRadius = 10
        UserDefaults.standard.removeObject(forKey: "register")
        // Do any additional setup after loading the view.
    }
  
    

    @IBOutlet weak var confirm: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var mail: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var bu: UIButton!
    
    @IBAction func signup(_ sender: Any) {
        let vc = LoginService(delegate: self)
      vc.sign(name: name.text!, email: mobile.text!, password: pass.text!, ext: "register")
       
    }
   
    @IBOutlet weak var checkbox: UIButton!
    
    let full = UIImage(systemName: "rectangle.fill")
    let blanck = UIImage(systemName: "rectangle")
    @IBAction func terms(_ sender: Any) {
        checkbox.setImage(full, for: .normal)
    }
    
    @IBOutlet weak var disshow: UIButton!
    @IBAction func conditions(_ sender: Any) {
    }
    @IBAction func skip(_ sender: Any) {
        self.performSegue(withIdentifier: "done", sender: nil)
        
    }

    @IBAction func sho(_ sender: Any) {
              if  pass.isSecureTextEntry == true
              {
                 
                  pass.isSecureTextEntry=false
                disshow.isHidden = false
                
              }
              else
              {
                  
                  pass.isSecureTextEntry=true
                   disshow.isHidden = true
              }
          }
   
         
         /*
         // MARK: - Navigation

         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destination.
             // Pass the selected object to the new view controller.
         }
         */
         func alertt(header:String,body:String ) {
                let alert = UIAlertController(title: header, message: body , preferredStyle: UIAlertController.Style.actionSheet)
                                  
                                  self.present(alert, animated: true, completion: nil)
                              let when = DispatchTime.now() + 2
                              DispatchQueue.main.asyncAfter(deadline: when){
                                // your code with delay
                                alert.dismiss(animated: true, completion: nil)
                              }
}
}

extension SignupViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    func didFailToReceiveDataWithError(error: Error) {
        
    }
    
    
}
