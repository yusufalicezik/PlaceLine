//
//  HomeViewController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import CoreLocation
class HomeViewController: UIViewController {
    var delegate:HamburgerMenuDelegate?
    @IBOutlet weak var tableView: UITableView!
    let locationManager = CLLocationManager()
    private var currentLocation:CLLocationCoordinate2D?
    lazy var homeViewModel:HomeViewModel = {
        return HomeViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setup()
    }
    fileprivate func setup(){
        getUserLocation()
        self.tableView.allowsSelection = false
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
    private func getUserLocation(){
        locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
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
            mCell.cellDelegate = self
        }else{
            cell = (tableView.dequeueReusableCell(withIdentifier: "lineCell", for: indexPath) as? LineCell)!
            guard let mCell = cell as? LineCell else{ return UITableViewCell()}
            if let mLocation = self.currentLocation{
                let distanceString = homeViewModel.planListViewModel.getItemAt(index: indexPath.row).getVenueDistance(mLocation)
                mCell.distanceKmLabel.text = distanceString
            }
            if homeViewModel.planListViewModel.isLast(homeViewModel.planListViewModel.getItemAt(index: indexPath.row)){
                mCell.bottomLine.isHidden = false
            }else{
                mCell.bottomLine.isHidden = true
            }
            mCell.configureCell(homeViewModel.planListViewModel.getItemAt(index: indexPath.row))
        }
        return cell
        
    }
}

extension HomeViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = manager.location!.coordinate
        fetchDataFromLocal()
    }
}
extension HomeViewController:CellDelegate{
    func didClickedItem(_ planViewModel: PlanViewModel) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DistanceVC") as? DistanceViewController
        guard let sourceLocation = self.currentLocation, let destinationLocation = planViewModel.plan.plan?.venue_location else {return}
        vc?.sourceLocation = sourceLocation
        vc?.destinationLocation = destinationLocation
        vc?.destinationTitle = planViewModel.venueName
        self.present(vc!, animated: true, completion: nil)
    }
    
    
}
