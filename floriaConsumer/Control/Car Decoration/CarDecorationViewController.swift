//
//  CarDecorationViewController.swift
//  floriaConsumer
//
//  Created by arabpas on 12/3/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit
import Popover

class CarDecorationViewController: UIViewController {
    
    
    static func newInstance() -> CarDecorationViewController {
        let storyboard = UIStoryboard.init(name: "CarDecoration", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CarDecorationViewController") as! CarDecorationViewController
        return vc
    }
    
    @IBOutlet var carButtons: [UIButton]!
    @IBOutlet var decorationTypeButtons: [UIButton]!
    @IBOutlet var shadowedViews: [UIView]!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorNameLabel: UIButton!


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
        orderRequest.carTypeId = sender.tag
    }
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        decorationTypeButtons.forEach { (button) in
            button.isSelected = false
        }
        sender.isSelected = true
        orderRequest.decorationTypeId = sender.tag
        
        let subView = TipView.newInstance(id: sender.tag)
        let options = [
          .type(.up),
          .cornerRadius(5),
          .animationIn(0.3),
          .blackOverlayColor(.clear)//,
          //.arrowSize(CGSize.zero)
          ] as [PopoverOption]
        let popover = Popover(options: options, showHandler: nil, dismissHandler: nil)
        popover.show(subView, fromView: sender)
        
        
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if validation() {
            let vc = VendorsListViewController.newInstance(service: .carDecoration)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let vc = segue.destination as? ColorsPopupViewController {
            vc.delegate = self
        }
    }
    
    func validation() -> Bool {
        if orderRequest.colorId == nil {
            alertWithMessage(title: "Choose car color")
            return false
        }
        if orderRequest.carTypeId == nil {
            alertWithMessage(title: "Choose car type")
            return false
        }
        if orderRequest.decorationTypeId == nil {
            alertWithMessage(title: "Choose decorarion type")
            return false
        }
        return true
    }
    
}

extension CarDecorationViewController: ColorsViewDelegate {
    func didSelectColor(_ color: CarColor) {
        colorView.backgroundColor = UIColor.init(hexString: color.code)
        colorNameLabel.setTitle(color.name, for: .normal)
        orderRequest.colorId = color.id
    }
}
