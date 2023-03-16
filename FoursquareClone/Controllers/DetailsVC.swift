//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Türker Berk Topçu on 15.03.2023.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var selectedId: String?
    var latitude: Double?
    var longitude: Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: #selector(back))
        
        
        
        }
    
    @objc func back(){}

    func createAnnotation(){
        
        let location = CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        
        self.mapView.setRegion(region, animated: true)
      
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
        self.mapView.addAnnotation(annotation)
    }
    
    
    func fetchData() {
        let query = PFQuery(className: "places").whereKey("objectId", equalTo: self.selectedId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                let alert = self.makeAlert(title: "Error !", message: error?.localizedDescription ?? "Unrecognized Error !")
                self.present(alert, animated: true)
            } else {
                if objects != nil {
                    for object in objects! {
                        if let placeName = object.object(forKey: "placeName") as? String {
                            self.nameLabel.text = placeName
                        }
                        if let placeType = object.object(forKey: "placeType") as? String {
                            self.typeLabel.text = placeType
                        }
                        if let placeDetails = object.object(forKey: "placeDetails") as? String {
                            self.detailsLabel.text = placeDetails
                        }
                        if let imageData = object.object(forKey: "imgData") as? PFFileObject {
                            imageData.getDataInBackground { data, error in
                                if error != nil {
                                    let alert = self.makeAlert(title: "Error !", message: error?.localizedDescription ?? "Unrecognized Error")
                                    self.present(alert, animated: true)
                                } else {
                                    self.imageView.image = UIImage(data: data!)
                                }
                            }
                        }
                        if let latitude = object.object(forKey: "latitude") as? Double {
                            if let longitude = object.object(forKey: "longitude") as? Double {
                                self.latitude = latitude
                                self.longitude = longitude
                                self.createAnnotation()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        return alert
    }
    
    
}
