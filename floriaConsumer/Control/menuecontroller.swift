//
//  menuecontroller.swift
//  floriaConsumer
//
//  Created by mac on 18/02/1441 AH.
//  Copyright © 1441 Obida. All rights reserved.
//

import UIKit

class menuecontroller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.string(forKey: "userid") == nil {
           
        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var logout: UIButton!
    @IBAction func out(_ sender: Any) {
        Defaults.init().isUserLogged = false
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - Actions
    
    @IBAction func onOrdersClick(_ sender: UIButton) {
        //print("😉 onOrdersClick")
        performSegue(withIdentifier: "Segue2Orders", sender: self)
    }
}
