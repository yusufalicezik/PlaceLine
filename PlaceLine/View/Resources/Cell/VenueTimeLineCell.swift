//
//  VenueTimeLineCell.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SDWebImage
protocol CellDelegate {
    func didClickedItem(_ planViewModel:PlanViewModel)
}
class VenueTimeLineCell: UITableViewCell {
    @IBOutlet weak var venueShortAddressLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var venueTypeImageView: UIImageView!
    var viewModel:PlanViewModel?
    var cellDelegate:CellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.venueNameLabel.isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didClicked))
        self.venueNameLabel.addGestureRecognizer(recognizer)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ planViewModel:PlanViewModel){
        self.viewModel = planViewModel
        venueNameLabel.text = planViewModel.venueName
        venueShortAddressLabel.text = planViewModel.venueShortAddress
        venueTypeImageView.sd_setImage(with: URL(string: planViewModel.venueImage), placeholderImage: UIImage(named: "placeholder.png"))
        containerView.layer.cornerRadius = 22.5 //circle
    }
    @objc private func didClicked(){
        guard let viewModel = self.viewModel else {return}
        cellDelegate?.didClickedItem(viewModel)
    }

}
