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
let vc = providerprofile()
        vc.corner(bu: one, by: 10)
        vc.corner(bu: two, by: 10)
        vc.corner(bu: three, by: 10)
    }

    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
