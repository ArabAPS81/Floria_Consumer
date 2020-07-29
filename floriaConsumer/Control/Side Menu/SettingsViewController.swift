//
//  SettingsViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 1/19/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit
import MaterialShowcase

class SettingsViewController: UITableViewController {
    
    @IBOutlet weak var tutorialSwitch: UISwitch!
    @IBOutlet weak var logButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        title = NSLocalizedString("settings", comment: "")
        tutorialSwitch.isOn = !UserDefaults.standard.bool(forKey: "ShowCasesOff")
        
        
        
        
        if Defaults().isUserLogged {
            logButton.setTitle(NSLocalizedString("Logout", comment: ""), for: .normal)
        }else {
            logButton.setTitle(NSLocalizedString("Login", comment: ""), for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath.init(row: 0, section: 0) {
            changeLanguage()
        }else if indexPath == IndexPath.init(row: 1, section: 0){
            
        }
    }
    
    @IBAction func tutorialTapped(_ sender: UISwitch) {
        if sender.isOn{
            let showCaseSequence = MaterialShowcaseSequence()
            showCaseSequence.removeUserState(key: "ShowCasesKey")
            UserDefaults.standard.set(false, forKey: "ShowCasesOff")
        }else{
            let showCaseSequence = MaterialShowcaseSequence()
            showCaseSequence.setKey(key: "ShowCasesKey")
            UserDefaults.standard.set(true, forKey: "ShowCasesOff")
        }
    }
    
    
    func changeLanguage() {
        let alert = UIAlertController.init(title: NSLocalizedString("Change Language", comment: ""), message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction.init(title: "English", style: UIAlertAction.Style.default, handler: { (action) in
            self.setEnglishLanguage()
        }))
        alert.addAction(UIAlertAction.init(title: "العربية", style: UIAlertAction.Style.default, handler: { (action) in
            self.setArabicLanguage()
        }))
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("cancel", comment: ""), style: UIAlertAction.Style.cancel, handler: nil))
        alert.view.tintColor = Constants.pincColor
        self.present(alert, animated: true, completion: nil)
    }
    
    func setArabicLanguage() {
        showRestartAlert("ar")
    }
    
    func setEnglishLanguage() {
        showRestartAlert("en")
    }
    
    func showRestartAlert(_ lang: String) {
        let alert = UIAlertController.init(title: NSLocalizedString("restart app", comment: ""), message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("yes", comment: ""), style: UIAlertAction.Style.default, handler: { (action) in
            UserDefaults.standard.set([lang], forKey: "AppleLanguages")
            exit(0)
        }))
        alert.addAction(UIAlertAction.init(title: NSLocalizedString("cancel", comment: ""), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        if Defaults().isUserLogged {
            Defaults.init().isUserLogged = false
            Defaults().saveUserData(email: "", name: "", phone: "")
            self.navigationController?.popViewController(animated: true)
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
    
}
