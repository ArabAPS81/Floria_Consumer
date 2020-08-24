//
//  LaunchViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 8/17/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Defaults.init().isUserLogged{
            let storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "homeNav") as! HomeNav
            homeVC.modalPresentationStyle = .fullScreen
            self.present(homeVC, animated: false, completion: nil)
        }else {
            if Defaults().getIfFirstTime() {
                let storyboard = UIStoryboard(name: "Splash", bundle: nil)
                let homeVC = storyboard.instantiateInitialViewController()
                homeVC?.modalPresentationStyle = .fullScreen
                self.present(homeVC!, animated: false, completion: nil)
            } else {
                let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
                let homeVC = storyboard.instantiateInitialViewController()
                homeVC?.modalPresentationStyle = .fullScreen
                self.present(homeVC!, animated: false, completion: nil)
            }
        }

    }
}
