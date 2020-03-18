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
        let vc = storyboard.instantiateViewController(identifier: "EditProfileViewController") as! EditProfileViewController
        return vc
    }
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userMailLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setData() {
        let user = Defaults().getUser()
        userMailLabel.text = user.email
        userNameLabel.text = user.name
    }
    
}
