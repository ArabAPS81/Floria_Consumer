//
//  LaunchViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 8/17/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit
import Firebase

let KcurrentVersion = 125

class LaunchViewController: UIViewController {
    
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        needsUpdate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        

    }
    
    func needsUpdate() {
        let postRef = ref.child("iOSVersion")
        _ = postRef.observe(DataEventType.value, with: { (snapshot) in
          let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if let lastVersion = postDict["ForceUpdate"] as? Int {
                self.chechVersion(version: lastVersion)
            }
        })
    }
    
    func chechVersion(version: Int) {
        if version > KcurrentVersion {
            updateAlert()
        }else {
            navigation()
        }
    }
    
    func navigation() {
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
    
    func updateAlert() {
        let alrt = UIAlertController.init(title: nil, message: NSLocalizedString("You have to update Floria APP to newer version", comment: ""), preferredStyle: .alert)
        alrt.addAction(UIAlertAction.init(title: NSLocalizedString("Update", comment: ""), style: .default, handler: { (action) in
            UIApplication.shared.open(URL.init(string: "https://apps.apple.com/app/id1503883347")!, options: [:], completionHandler: nil)
        }))
        self.present(alrt, animated: true, completion: nil)
    }
    
}
