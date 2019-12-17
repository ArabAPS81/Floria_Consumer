//
//  TipView.swift
//  floriaConsumer
//
//  Created by arabpas on 12/16/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit


class TipView: UIView {
    
    static func newInstance() -> TipView {
        let view = UINib.init(nibName: "TipView", bundle: nil).instantiate(withOwner: self, options: nil).first as! TipView
        return view
    }
    
    
}
