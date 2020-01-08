//
//  menuecontroller.swift
//  floriaConsumer
//
//  Created by mac on 18/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit

class menuecontroller: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userMailLabel: UILabel!
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userPhoneLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = Defaults().getUser()
        userMailLabel.text = user.email
        userNameLabel.text = user.name
        userPhoneLabel.text = user.phone
        
    }
    @IBOutlet weak var logout: UIButton!
    @IBAction func out(_ sender: Any) {
        Defaults.init().isUserLogged = false
    }
    
    @IBAction func onOrdersClick(_ sender: UIButton) {
        //print("😉 onOrdersClick")
        performSegue(withIdentifier: "Segue2Orders", sender: self)
    }
}
