//
//  SearchResultVenueCell.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SDWebImage
class SearchResultVenueCell: UITableViewCell {

    @IBOutlet weak var venueIconImageView: UIImageView!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var venueAddressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(venueViewModel:VenueViewModel){
        venueNameLabel.text = venueViewModel.venueName
        venueAddressLabel.text = venueViewModel.venueShortAddres
        venueIconImageView.sd_setImage(with: URL(string: venueViewModel.venueIconUrl)!, placeholderImage: UIImage(named: "p"))
    }

}
