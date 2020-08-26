//
//  menuecontroller.swift
//  floriaConsumer
//
//  Created by mac on 18/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    
    
    @IBOutlet var sideMenuButtons: [UIButton]!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userMailLabel: UILabel!
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet var logedUserViews: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Defaults().getUser()
        userMailLabel.text = user.email
        userNameLabel.text = user.name
        userPhoneLabel.text = user.phone
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.tintColor = .red
        self.navigationController?.navigationBar.barTintColor = .red
        
        if Defaults().isUserLogged {
            logButton.setTitle(NSLocalizedString("Logout", comment: ""), for: .normal)
            logedUserViews.forEach {$0.isHidden = false}
            
        }else {
            logButton.setTitle(NSLocalizedString("Login", comment: ""), for: .normal)
            logedUserViews.forEach {$0.isHidden = true}
        }
        
        for button in sideMenuButtons {
            button.contentHorizontalAlignment = .leading
        }
    }
    
    @IBAction func editProfileTapped(_ sender: Any) {
        if Defaults().isUserLogged {
            let vc = EditProfileViewController.newInstance()
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let nav = storyboard.instantiateInitialViewController() as! UINavigationController
            nav.modalPresentationStyle = .fullScreen
            let vc = nav.viewControllers.first as! LoginViewController
            vc.event = {vc in
                vc.dismiss(animated: true, completion: nil)
            }
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func termsTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let termsVC = storyboard.instantiateViewController(withIdentifier: "termsVC") as! TermsViewController
        self.navigationController?.pushViewController(termsVC, animated: true)
    }
    
    
    
    @IBAction func out(_ sender: Any) {
        if Defaults().isUserLogged {
            
            let service = AuthenticationService.init(delegate: self)
            service.logout()
            
            Defaults.init().isUserLogged = false
            Defaults().saveUserData(email: "", name: "", phone: "")
            self.dismiss(animated: true)
        }else {
            let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
            let nav = storyboard.instantiateInitialViewController() as! UINavigationController
            nav.modalPresentationStyle = .fullScreen
            let vc = nav.viewControllers.first as! LoginViewController
            vc.event = {vc in
                vc.dismiss(animated: true, completion: nil)
            }
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    @IBAction func onOrdersClick(_ sender: UIButton) {
        //print("😉 onOrdersClick")
        performSegue(withIdentifier: "Segue2Orders", sender: self)
    }
}

extension SideMenuViewController: WebServiceDelegate {
    func didRecieveData(data: Codable) {
        
    }
    
    
}

