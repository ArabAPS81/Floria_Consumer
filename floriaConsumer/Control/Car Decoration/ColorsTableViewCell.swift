//
//  ColorsTableViewCell.swift
//  floriaConsumer
//
//  Created by arabpas on 12/4/19.
//  Copyright © 2019 Obida. All rights reserved.
//

import UIKit

class ColorsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let view = UIView.init()
        view.backgroundColor = .red
        self.selectedBackgroundView = view
    }

}
