//
//  HomeViewController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
class HomeViewController: UIViewController {
    var delegate:HamburgerMenuDelegate?
    @IBOutlet weak var tableView: UITableView!
    lazy var homeViewModel:HomeViewModel = {
        return HomeViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    fileprivate func setup(){
        self.tableView.allowsSelection = false
        fetchDataFromLocal()
    }
    @IBAction func hamburgerMenuClicked(_ sender: Any) {
        delegate?.didTapButton()
    }
    fileprivate func fetchDataFromLocal(){
        homeViewModel.fetchDataFromLocal { [weak self] isFinished in
            if isFinished{
                DispatchQueue.main.async {
                    self!.tableView.reloadData()
                }
            }
        }
    }
}
extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.planListViewModel.numberOfRowsInSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if homeViewModel.planListViewModel.getItemAt(index: indexPath.row).isPlan{
            cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VenueTimeLineCell)!
            guard let mCell = cell as? VenueTimeLineCell else{ return UITableViewCell()}
            mCell.configureCell(homeViewModel.planListViewModel.getItemAt(index: indexPath.row))
        }else{
            cell = (tableView.dequeueReusableCell(withIdentifier: "lineCell", for: indexPath) as? LineCell)!
        }
        return cell
        
    }
}

