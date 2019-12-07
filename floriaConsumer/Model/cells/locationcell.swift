//
//  locationcell.swift
//  floriaConsumer
//
//  Created by mac on 12/1/2562 BE.
//  Copyright © 2562 BE Obida. All rights reserved.
//

import UIKit

class locationcell: UITableViewCell {

    @IBOutlet weak var icone: UIImageView!
    var openProfileActionadd : (()->())?
      @IBAction func penProfileActionadd(_ sender: UIButton) {
          openProfileActionadd?()
      }

    @IBOutlet weak var SelectionButtonalyout: UIButton!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        selectedBackgroundView = UIView()
        
        if selected {
            SelectionButtonalyout.backgroundColor = Constants.pincColor
        }else {
            SelectionButtonalyout.backgroundColor = UIColor.init(red: 128/255, green: 128/255, blue: 128/255, alpha: 1)
        }
        
        
    }
}
