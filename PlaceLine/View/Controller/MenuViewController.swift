//
//  MenuViewController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
protocol MenuSelectDelegate {
    func didClickedItem(_ index:Int)
}
protocol HamburgerMenuDelegate{
    func didTapButton()
}
class MenuViewController: UIViewController {
    
    let menuItems = ["Anasayfa", "Yeni Hedef", "Ayarlar", "Çıkış"]
    let menuItemsIcon = ["home", "profile", "settings", "logout"]
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var profileNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var menuDelegate:MenuSelectDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImg.layer.cornerRadius = self.profileImg.frame.width / 2
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
}
extension MenuViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MenuCell
        cell?.itemNameLabel.text = menuItems[indexPath.row]
        cell?.itemIcon.image = UIImage(named: menuItemsIcon[indexPath.row])
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menuDelegate?.didClickedItem(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
