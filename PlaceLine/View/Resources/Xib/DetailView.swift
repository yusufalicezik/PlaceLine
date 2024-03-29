//
//  DetailView.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import SDWebImage
import AnimatedCollectionViewLayout
import CoreData
import PopupDialog
class DetailView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    private var bottomConstraint:NSLayoutConstraint?
    var imageUrlDataList = [String]()
    var venueViewModel:VenueViewModel?
    var menuDelegate:MenuSelectDelegate?
    var width:CGFloat?
    var parent:UIViewController?
    var nib:UINib?
    func loadNib(_ parent:UIViewController){
        imageUrlDataList.removeAll()
        collectionView.delegate = self
        collectionView.dataSource = self
        nib = UINib(nibName: "PhotosCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "cell")
        self.parent = parent
        if let city = venueViewModel{
            self.titleLabel.text = city.venueName
            self.addressLabel.text = city.venueLocatin.address
        }
        self.layer.cornerRadius = 10
        self.frame = CGRect(x: 25, y: parent.view.bounds.height+2, width: parent.view.bounds.width-50.0, height: 230)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: parent.view.leftAnchor, constant: 25.0).isActive = true
        self.rightAnchor.constraint(equalTo: parent.view.rightAnchor, constant: -25.0).isActive = true
        self.width = (parent.view.bounds.width) - 50
        self.heightAnchor.constraint(equalToConstant: 230.0).isActive = true
        setCollectionLayout()
        giveAnimate(parent)
    }
    private func giveAnimate(_ parent:UIViewController){
        bottomConstraint = self.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor, constant: -50)
        bottomConstraint?.isActive = true
        UIView.animate(withDuration: 0.4){
            parent.view.layoutSubviews()
        }
    }
    private func setCollectionLayout(){
        let layout = AnimatedCollectionViewLayout()
        layout.animator = LinearCardAttributesAnimator()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let size = self.frame
        layout.itemSize = CGSize(width: size.width-70, height: self.collectionView.frame.height)
        let numberOfCells = floor(self.frame.size.width / width!)
        let edgeInsets = (self.frame.size.width - (numberOfCells * width!)) / (numberOfCells + 1)

        layout.sectionInset = UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
        collectionView.isPagingEnabled = false
        collectionView.collectionViewLayout = layout
    }
    @IBAction func closeClicked(_ sender: Any) {
        bottomConstraint?.isActive = false
        bottomConstraint = self.bottomAnchor.constraint(equalTo: parent!.view.bottomAnchor, constant: 235)
        bottomConstraint?.isActive = true
        UIView.animate(withDuration: 0.4){
            self.parent!.view.layoutSubviews()
        }
        //self.removeFromSuperview()
    }
    @IBAction func addListClicked(_ sender: Any) {
        let delegate=UIApplication.shared.delegate as! AppDelegate
        let context=delegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Plan", in: context)
        let plan = NSManagedObject(entity: entity!, insertInto: context)
        plan.setValue(false, forKey: "isDone")
        //plan.setValue(venueViewModel?.venu, forKey: "venue_description")
        plan.setValue(venueViewModel?.venueIconUrl, forKey: "venue_image")
        plan.setValue(venueViewModel?.venueName, forKey: "venue_name")
        plan.setValue(venueViewModel?.venueShortAddres, forKey: "venue_short_address")
        plan.setValue(venueViewModel?.venueLocatin.lat, forKey: "lat")
        plan.setValue(venueViewModel?.venueLocatin.lng, forKey: "long")
        plan.setValue(venueViewModel?.venueId, forKey: "id")
        plan.setValue(Date(), forKey: "venue_time")
        do {
            try context.save()
            self.openPopup()
        } catch {
            print("Failed saving")
        }
      
    }
    private func openPopup(){
        let popup = PopupDialog(title: "Başarılı", message: "Yeni plan eklendi", image: nil)
        guard let parentVC = self.parent as? MapViewController else {return}
        let buttonOk = DefaultButton(title: "Tamam", dismissOnTap: true) {
            parentVC.backPressed()
            parentVC.menuDelegate?.didClickedItem(0)
        }
        popup.addButton(buttonOk)
        parentVC.present(popup, animated: true, completion:nil)
        
    }
    
}
extension DetailView:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrlDataList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotosCell
        //DispatchQueue.main.async {
            cell?.photoImageView.sd_setImage(with: URL(string: self.imageUrlDataList[indexPath.row]), placeholderImage: UIImage(named: "profilex.png"), options:SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
                self.loadingIndicator.stopAnimating()
            })
        //}
        cell?.photoImageView.layer.cornerRadius = 8
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.frame
        return CGSize(width: size.width, height: self.collectionView.frame.height)
    }
 
}

