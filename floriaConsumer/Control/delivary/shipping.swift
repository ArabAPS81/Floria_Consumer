//
//  shipping.swift
//  floriaConsumer
//
//  Created by mac on 11/13/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class shipping: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pay.layer.cornerRadius = 15
        
       ViewAsCell.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                  ViewAsCell.layer.shadowOffset = CGSize(width: 0.1, height: 3.0)
               ViewAsCell.layer.shadowOpacity = 1
        ViewAsCell.layer.cornerRadius = 40
        
        Vendorpic.layer.cornerRadius = 25
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBOutlet weak var pay: UIButton!
    @IBOutlet weak var Vendorpic: UIImageView!
    
    @IBOutlet weak var ViewAsCell: UIView!
    @IBAction func back(_ sender: Any) {
           self.dismiss(animated: true, completion: nil)
       }

}
