//
//  buttons.swift
//  floriaConsumer
//
//  Created by mac on 11/12/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class buttons: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Shadoow(bu: one)
        Shadoow(bu: two)
        Shadoow(bu: three)
        title = NSLocalizedString("delivery", comment: "")
    }

    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func Shadoow(bu: UIButton ){
        bu.layer.shadowColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
           bu.layer.shadowOffset = CGSize(width: 0.1, height: 3.0)
        bu.layer.shadowOpacity = 1
    }

    @IBAction func ME(_ sender: Any) {
        orderRequest.shipping = 1
        performSegue(withIdentifier: "addresses", sender: nil)
    }
    @IBAction func somewhere(_ sender: Any) {
        orderRequest.shipping = 2
        performSegue(withIdentifier: "addresses", sender: nil)
    }
    @IBAction func vendor(_ sender: Any) {
        if Defaults().isUserLogged {
            orderRequest.shipping = 3
            performSegue(withIdentifier: "shiping", sender: nil)
        } else {
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
