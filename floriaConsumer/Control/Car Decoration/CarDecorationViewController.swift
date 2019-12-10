//
//  CarDecorationViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/3/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class CarDecorationViewController: UIViewController {
    
    
    static func newInstance() -> CarDecorationViewController {
        let storyboard = UIStoryboard.init(name: "CarDecoration", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CarDecorationViewController") as! CarDecorationViewController
        return vc
    }
    
    
    @IBOutlet var carButtons: [UIButton]!
    @IBOutlet var decorationTypeButtons: [UIButton]!
    @IBOutlet var shadowedViews: [UIView]!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
       
    }
    
    func setupViews() {
        carButtons.forEach { (button) in
            button.layer.cornerRadius = 36
            button.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            button.tintColor = Constants.pincColor
            button.dropRoundedShadowForAllSides(36)
        }
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        shadowedViews.forEach { view in
            view.dropRoundedShadowForAllSides(5)
        }
    }
    
    @IBAction func carButtonTapped(_ sender: UIButton) {
        carButtons.forEach { (button) in
            button.backgroundColor = #colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9490196078, alpha: 1)
            button.tintColor = Constants.pincColor
        }
        sender.backgroundColor = Constants.pincColor
        sender.tintColor = .white
    }
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        decorationTypeButtons.forEach { (button) in
            button.isSelected = false
        }
        sender.isSelected = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
    }

}
