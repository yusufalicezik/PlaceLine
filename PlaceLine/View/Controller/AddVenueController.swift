//
//  AddVenueController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 18.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SDWebImage

class AddVenueController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var dataList = [Venue]()
    var delegate:HamburgerMenuDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }
    private func setup(){
        tableView.tableFooterView = UIView()
        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
    }

    fileprivate func searchVenue(withKey:String){
        if withKey.isEmpty{
            self.dataList.removeAll()
            self.tableView.reloadData()
        }else{
            PlaceServiceManager.shared.getVenuesForQuickSearch(byVenueName: withKey) { [weak self] city in
                print(withKey)
                self?.dataList = city.response.venues
                DispatchQueue.main.async {
                    self!.tableView.reloadData()
                }
            }
        }
    }
    @objc func textFieldDidChange(_ textfield:UITextField){
        PlaceServiceManager.shared.currentRequest?.cancel()
        self.searchVenue(withKey: textfield.text!)
    }
    @IBAction func menuButtonClicked(_ sender: Any) {
        delegate?.didTapButton()
    }
}

extension AddVenueController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchResultVenueCell
        cell?.venueNameLabel.text = dataList[indexPath.row].name
        cell?.venueAddressLabel.text = dataList[indexPath.row].location.address
        cell?.venueIconImageView.sd_setImage(with: URL(string: dataList[indexPath.row].categories[0].icon!.prefix!+"64"+dataList[indexPath.row].categories[0].icon!.suffix!), placeholderImage: UIImage(named: "placeholder.png"))

        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapViewController
        vc?.city = self.dataList[indexPath.row]
        self.present(vc!, animated: true, completion: nil)
    }
}
