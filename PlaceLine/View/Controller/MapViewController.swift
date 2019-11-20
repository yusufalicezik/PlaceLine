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
    var city:VenueViewModel?
    weak var detailsView:DetailView?
    var annotation:MKPointAnnotation?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        // Do any additional setup after loading the view.
    }
    private func setupMap(){
        mapView.delegate = self
        if let city = self.city{
            annotation = MKPointAnnotation()
            annotation?.coordinate = CLLocationCoordinate2D(latitude: city.venueLocatin.lat, longitude: city.venueLocatin.lng)
            self.mapView.addAnnotation(annotation!)
            let diameter = 0.75 * 2000
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: city.venueLocatin.lat, longitude: city.venueLocatin.lng), latitudinalMeters: diameter, longitudinalMeters: diameter)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    fileprivate func getDetailsView(){
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk()
        detailsView?.nib = nil
        detailsView?.removeFromSuperview()
        detailsView = Bundle.main.loadNibNamed("DetailView", owner: self, options: nil)?.first as? DetailView
        self.view.addSubview(detailsView!)
        detailsView?.city = self.city!
        detailsView?.loadNib(self)
        ImageServiceManager.shared.getFlickrImageUrl(annotation!) {[weak self] (imageList) in
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
        detailsView?.nib = nil
        mapView.delegate = nil
        self.detailsView?.removeFromSuperview()
        self.detailsView = nil
        mapView.removeFromSuperview()
        mapView = nil
        self.dismiss(animated: true, completion: nil)
    }
}
extension MapViewController:MKMapViewDelegate{
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        if annotation is MKUserLocation{return nil}
//        var customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationV")
//        if customAnnotationView == nil{
//            customAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotationV")
//            customAnnotationView?.canShowCallout = true
//        }else{
//            customAnnotationView?.annotation = annotation
//        }
//        if let mAnnotation = annotation as? CustomAnnotation{
//            customAnnotationView?.image = UIImage(named: "pin")
//            //customAnnotationView
//        }
//        return customAnnotationView
//    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        getDetailsView()
    }
}
