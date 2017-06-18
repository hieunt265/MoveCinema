//
//  CellMove.swift
//  MoveCinema
//
//  Created by Jax on 6/17/17.
//  Copyright © 2017 Jax. All rights reserved.
//

import UIKit

class CellMove: UITableViewCell {
	@IBOutlet weak var imgAvatarMove: UIImageView!
	@IBOutlet weak var lbTitle: UILabel!
	@IBOutlet weak var lbOverview: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
