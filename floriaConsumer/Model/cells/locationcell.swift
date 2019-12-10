//
//  locationcell.swift
//  floriaConsumer
//
//  Created by mac on 12/1/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class locationcell: UITableViewCell {

    @IBOutlet weak var shadowedView: UIView!
    @IBOutlet weak var icone: UIImageView!
    var openProfileActionadd : (()->())?
    
    
      @IBAction func penProfileActionadd(_ sender: UIButton) {
          openProfileActionadd?()
      }

    override func awakeFromNib() {
        super.awakeFromNib()
        let frame = shadowedView.frame
        shadowedView.frame = CGRect.init(x: frame.origin.x, y: frame.origin.y, width: UIScreen.main.bounds.width - 20, height: frame.height)
        
    }
    
    
    var shadowAdded = false
    override func layoutSubviews() {
        super.layoutSubviews()
        if !shadowAdded{
            shadowedView.dropRoundedShadowForAllSides(5)
            shadowAdded = true
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        selectedBackgroundView = UIView()
        
        if selected {
            shadowedView.backgroundColor = Constants.pincColor
            icone.tintColor = .white
        }else {
            shadowedView.backgroundColor = UIColor.init(red: 235/255, green: 235/255, blue: 235/255, alpha: 1)
            icone.tintColor = Constants.pincColor
        }
        
        
    }
}
