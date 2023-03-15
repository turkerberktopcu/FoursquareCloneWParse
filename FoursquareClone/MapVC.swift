//
//  MapViewController.swift
//  FoursquareClone
//
//  Created by Türker Berk Topçu on 13.03.2023.
//

import UIKit
import MapKit
import Parse

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var placeToSave: Places? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveClicked))
    }
    
    @objc func saveClicked(){
        
    }


}
