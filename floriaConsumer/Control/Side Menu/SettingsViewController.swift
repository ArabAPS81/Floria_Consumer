//
//  SettingsViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 1/19/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        title = NSLocalizedString("settings", comment: "")
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath == IndexPath.init(row: 0, section: 0) {
            changeLanguage()
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
    
}
