//
//  LineCell.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit

class LineCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var isDoneLabel: UILabel!
    @IBOutlet weak var distanceKmLabel: UILabel!
    @IBOutlet weak var bottomLine: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(_ planViewModel:PlanViewModel ){
        //descriptionLabel.text = planViewModel.venueDescription
        isDoneLabel.text = setLabelIsDone(planViewModel.isDone)
        timeLabel.text = planViewModel.venueTimeString
    }
    private func setLabelIsDone(_ isDone:Bool)->String{
        let returnedString = isDone ? "Tamamlandı" : "Bekliyor"
        isDoneLabel.textColor = isDone ? UIColor.green : UIColor.red
        return returnedString
    }

}
