//
//  AddVenueController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 18.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class AddVenueController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    private var venueListViewModel:VenueListViewModel!
    var delegate:HamburgerMenuDelegate?
    var menuDelegate:MenuSelectDelegate?
    var disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    private func setup(){
        tableView.tableFooterView = UIView()
        searchTextField.rx.text.subscribe(onNext:{[weak self] text in
            self?.searchVenue(withKey: text!)
        }).disposed(by: disposeBag)
    }
    fileprivate func searchVenue(withKey:String){
        PlaceServiceManager.shared.currentRequest?.cancel()
        if withKey.isEmpty{
            if venueListViewModel != nil {venueListViewModel.clearData()}
            self.tableView.reloadData()
        }else{
            PlaceServiceManager.shared.getVenuesForQuickSearch(byVenueName: withKey) { [weak self] city in
                print(withKey)
                self?.venueListViewModel = VenueListViewModel(city.response.venues)
                self?.updateUI()
            }
        }
    }
    private func updateUI(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    @IBAction func menuButtonClicked(_ sender: Any) {
        delegate?.didTapButton()
    }
}
extension AddVenueController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return venueListViewModel == nil ? 0 : venueListViewModel.numberOfRowsSection
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchResultVenueCell
        let venueViewModel = self.venueListViewModel.getVenueAt(index: indexPath.row)
        cell?.configureCell(venueViewModel: venueViewModel)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
        let vc = storyboard?.instantiateViewController(withIdentifier: "MapVC") as? MapViewController
        vc?.menuDelegate = self.menuDelegate
        vc?.venueViewModel = self.venueListViewModel.getVenueAt(index: indexPath.row)
        self.present(vc!, animated: true, completion: nil)
    }
}
