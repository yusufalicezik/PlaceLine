//
//  MenuCell.swift
//  SideMenu-WithChildVC
//
//  Created by Yusuf ali cezik on 2.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var itemIcon: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
