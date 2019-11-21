//
//  MapViewController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import MapKit
import SDWebImage
class MapViewController: UIViewController {
    @IBOutlet weak var mapView:MKMapView!
    var venueViewModel:VenueViewModel?
    weak var detailsView:DetailView?
    var menuDelegate:MenuSelectDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
    }
    private func setupMap(){
        mapView.delegate = self
        if let venueViewModel = self.venueViewModel{
            self.mapView.addAnnotation(venueViewModel.venueAnnotation)
            self.mapView.setRegion(venueViewModel.venueRegion, animated: true)
        }
    }
    fileprivate func getDetailsView(){
        clearDetailsView()
        detailsView = Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)?.first as? DetailView
        self.view.addSubview(detailsView!)
        detailsView?.venueViewModel = self.venueViewModel!
        detailsView?.loadNib(self)
        ImageServiceManager.shared.getFlickrImageUrl(venueViewModel!.venueAnnotation) {[weak self] (imageList) in
            self?.detailsView?.imageUrlDataList = imageList
            DispatchQueue.main.async {
                if imageList.isEmpty{self?.detailsView?.loadingIndicator.stopAnimating()}
                self?.detailsView?.collectionView.reloadData()
            }
        }
    }
    deinit {
        print("mapVC deinit")
    }
    @IBAction func backPressed(_ sender: Any) {
        self.backPressed()
    }
    private func clearDetailsView(){
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        detailsView?.nib = nil
        detailsView?.removeFromSuperview()
    }
    func backPressed(){ //for memory leak
        self.clearDetailsView()
        detailsView?.nib = nil
        mapView.delegate = nil
        mapView.removeFromSuperview()
        mapView = nil
        self.dismiss(animated: true, completion: nil)
    }
}
extension MapViewController:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        getDetailsView()
    }
}
