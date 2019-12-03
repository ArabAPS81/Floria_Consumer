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
}
