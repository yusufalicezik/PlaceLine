//
//  HomeViewController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SDWebImage
class HomeViewController: UIViewController {
    var delegate:HamburgerMenuDelegate?
    let dataList = ["","","","","","","","","","","","",""]
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup(){
        self.tableView.allowsSelection = false
    }
    @IBAction func hamburgerMenuClicked(_ sender: Any) {
        delegate?.didTapButton()
    }
}
extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if indexPath.row % 2 == 0{
            cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VenueTimeLineCell)!
            (cell as? VenueTimeLineCell)?.venueTypeImageView.sd_setImage(with: URL(string: "https://ss3.4sqi.net/img/categories_v2/shops/mall_64.png"), placeholderImage: UIImage(named: "placeholder.png"))
            (cell as? VenueTimeLineCell)?.containerView.layer.cornerRadius = 22.5 //circle
        }else{
            cell = (tableView.dequeueReusableCell(withIdentifier: "lineCell", for: indexPath) as? LineCell)!
        }
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
