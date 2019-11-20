//
//  HomeViewController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SDWebImage
import CoreData
class HomeViewController: UIViewController {
    var delegate:HamburgerMenuDelegate?
    //let dataList = ["","","","","","","","","","","","",""]
    @IBOutlet weak var tableView: UITableView!
    var dataList = [PlanData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchDataFromLocal()
    }
    fileprivate func setup(){
        self.tableView.allowsSelection = false
    }
    @IBAction func hamburgerMenuClicked(_ sender: Any) {
        delegate?.didTapButton()
    }
    fileprivate func fetchDataFromLocal(){
        dataList.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Plan")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                var mPlan = PlanModel()
                mPlan.isDone = false
                mPlan.venue_description = data.value(forKey: "venue_description") as? String
                mPlan.venue_name = data.value(forKey: "venue_name") as? String
                mPlan.venue_image = data.value(forKey: "venue_image") as? String
                mPlan.venue_short_address = data.value(forKey: "venue_short_address") as? String
                mPlan.venue_time = data.value(forKey: "venue_description") as? Date
                dataList.append(PlanData(plan:mPlan, isPlan: true))
                if data != result.last as! NSManagedObject{
                    dataList.append(PlanData(plan:nil, isPlan: false))
                }
                print(data.value(forKey: "venue_name") as! String)
            }
        } catch {
            print("Failed")
        }
    }
}
extension HomeViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if dataList[indexPath.row].isPlan{
            cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? VenueTimeLineCell)!
            guard let mCell = cell as? VenueTimeLineCell else{ return UITableViewCell()}
            mCell.venueNameLabel.text = dataList[indexPath.row].plan?.venue_name!
            mCell.venueShortAddressLabel.text = dataList[indexPath.row].plan?.venue_short_address ?? ""
            mCell.venueTypeImageView.sd_setImage(with: URL(string: dataList[indexPath.row].plan!.venue_image!), placeholderImage: UIImage(named: "placeholder.png"))
            mCell.containerView.layer.cornerRadius = 22.5 //circle
        }else{
            cell = (tableView.dequeueReusableCell(withIdentifier: "lineCell", for: indexPath) as? LineCell)!
        }
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
struct PlanData{
    var plan:PlanModel?
    var isPlan = false
}
struct PlanModel{
    var isDone:Bool?
    var venue_description:String?
    var venue_name:String?
    var venue_image:String?
    var venue_time:Date?
    var venue_short_address:String?
}
