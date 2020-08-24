//
//  ReciptView.swift
//  floriaConsumer
//
//  Created by arabpas on 8/11/20.
//  Copyright © 2020 Obida. All rights reserved.
//

import UIKit

class ReciptView: UIView {
    
    
    @IBOutlet weak var subTotal: UILabel!
    @IBOutlet weak var delivery: UILabel!
    @IBOutlet weak var vat: UILabel!
    @IBOutlet weak var bankservices: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var contentView: UIView!
    
    var order: Order?
    
    
    

    static func newInstance(order:Order) -> ReciptView {
        let view = UINib.init(nibName: "ReciptView", bundle: nil)
            .instantiate(withOwner: self, options: nil).first as! ReciptView
        view.order = order
        return view
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        subTotal.text = String(Int(order?.subtotal ?? 0))
        bankservices.text = String(Int(0))
        vat.text = String(Int(order?.totalTax ?? 0))
        delivery.text = String(Int(order?.delivery ?? 0))
        total.text = String(Int(order?.total ?? 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.layer.borderColor = #colorLiteral(red: 0.9692807794, green: 0, blue: 0.4361249506, alpha: 1)
        contentView.layer.borderWidth = 1
        self.backgroundColor = .clear
       
    }
    
    @IBAction func okTapped(_ sender: Any) {
        
    }

}
