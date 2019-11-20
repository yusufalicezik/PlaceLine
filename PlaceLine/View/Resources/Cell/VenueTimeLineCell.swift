//
//  VenueTimeLineCell.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SDWebImage
class VenueTimeLineCell: UITableViewCell {
    

    @IBOutlet weak var venueShortAddressLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var venueTypeImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ planViewModel:PlanViewModel){
        venueNameLabel.text = planViewModel.venueName
        venueShortAddressLabel.text = planViewModel.venueShortAddress
        venueTypeImageView.sd_setImage(with: URL(string: planViewModel.venueImage), placeholderImage: UIImage(named: "placeholder.png"))
        containerView.layer.cornerRadius = 22.5 //circle
    }

}
