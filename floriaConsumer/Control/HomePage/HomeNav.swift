//
//  HomeNav.swift
//  floriaConsumer
//
//  Created by Mariam on 12/30/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class HomeNav: UINavigationController {
    
    static func newInstance() -> HomeNav {
        let storyboard = UIStoryboard(name: "MainScreen", bundle: nil)
        let homeNav = storyboard.instantiateViewController(withIdentifier: "homeNav") as! HomeNav
        return homeNav

    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
