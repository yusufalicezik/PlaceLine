//
//  MapViewController.swift
//  PlaceLine
//
//  Created by Yusuf ali cezik on 19.11.2019.
//  Copyright © 2019 Yusuf Ali Cezik. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView:MKMapView!
    var city:Venue?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        // Do any additional setup after loading the view.
    }
    private func setupMap(){
        if let city = self.city{
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: city.location.lat, longitude: city.location.lng)
            mapView.addAnnotation(annotation)
        }
    }
//    @objc func openBottomPopup(){
//        print("asd")
//    }

    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
