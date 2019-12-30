//
//  ConfirmationCodeViewController.swift
//  floriaConsumer
//
//  Created by Mariam Elenna on 12/29/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class ConfirmationCodeViewController: UIViewController {
    @IBOutlet weak var timerLable: UILabel!
    
    @IBOutlet weak var resendBtn: UIButton!
    
    @IBOutlet weak var chagePassBtn: UIButton!
    
    var seconds = 60
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewsShapes()
        resendBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func confirmTapped(_ sender: Any) {
        
    }
    
    func setUpViewsShapes(){
        
        resendBtn.layer.cornerRadius = 15
        resendBtn.clipsToBounds = true
        
        resendBtn.layer.cornerRadius = 30
        resendBtn.clipsToBounds = true
        
    }
    
    @objc func UpdateTimer(){
        if seconds != 0 {
            seconds -= 1
            timerLable.text = "00:\(seconds)"
        }else{
            timerLable.text = "00:00"
            resendBtn.isHidden = false
            print("\(seconds)")
        }
        
    }
}
